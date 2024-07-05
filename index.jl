### A Pluto.jl notebook ###
# v0.19.43

using Markdown
using InteractiveUtils

# ╔═╡ 1efe8035-b81c-4585-9b16-3e8e4838da3f
# Utilities for importing and displaying data
using DataFrames, CSV, FilePaths, FilePathsBase, Dates

# ╔═╡ fdd82160-411c-403f-ad37-577d48f07542
function filter_duplicated_by_date(df)
    if length(unique(df.publication_date)) == 1
        return df
    else
        sorted_df = sort(df, :publication_date, rev=true)
        most_recent_date = sorted_df[1, :publication_date]
        return filter(row -> row[:publication_date] == most_recent_date, df)
    end
end

# ╔═╡ 26dffbb7-8892-46ec-838e-ddb05b4fd756
begin
	# Import all the raw data before processing
	food_path = p".\data\FoodData_Central_foundation_food_csv_2024-04-18\food.csv"
	food_nutrient_path =
		p".\data\FoodData_Central_foundation_food_csv_2024-04-18\food_nutrient.csv"
	nutrient_path = p".\data\FoodData_Central_foundation_food_csv_2024-04-18\nutrient.csv"
	food_df = DataFrame(CSV.File(food_path))
	food_nutrient_df = DataFrame(CSV.File(food_nutrient_path))
	nutrient_df = DataFrame(CSV.File(nutrient_path));
	# Keep only food such that it is a foundation food since is where data is most complete and precise
	food_df = food_df[food_df.data_type .== "foundation_food", :]
	# Drop data_type info since we using a single category
	select!(food_df, Not(:data_type))
	# Drop useless data
	select!(food_df, Not(:food_category_id))
	select!(food_nutrient_df, Not(:min))
	select!(food_nutrient_df, Not(:max))
	select!(food_nutrient_df, Not(:median))
	select!(food_nutrient_df, Not(:footnote))
	select!(food_nutrient_df, Not(:loq))
	select!(food_nutrient_df, Not(:min_year_acquired))
	select!(food_nutrient_df, Not(:id))
	select!(food_nutrient_df, Not(:derivation_id))
	select!(food_nutrient_df, Not(:data_points))
	select!(nutrient_df, Not(:rank))
	select!(nutrient_df, Not(:nutrient_nbr))
	# Drop older entries of duplicated foods
	group_duplicates = groupby(food_df, :description)
	food_df = vcat([filter_duplicated_by_date(df) for df in group_duplicates]...)
	# Keep only the food_nutrient_df entries that still have a match in food_df
	food_nutrient_df = food_nutrient_df[in.(food_nutrient_df.fdc_id, Ref(food_df.fdc_id)), :]
	# Drop nutrients that are recommended to not be used by the USDA
	filter!(row -> !occursin("DO NOT USE", row.name), nutrient_df)
	# Drop nutrients that have no match on food_nutrient_df
	nutrient_df = nutrient_df[in.(nutrient_df.id, Ref(food_nutrient_df.nutrient_id)), :]
	# Drop components that are non relevant to the nutritional analysis
	non_relevant = ("Nitrogen", "Ash", "Specific Gravity", "Water", "Citric acid", "Malic acid", "Oxalic acid", "Pyruvic acid", "Quinic acid", "Ergosterol", "Stigmasterol", "Campesterol", "Brassicasterol", "Beta-sitosterol", "Campestanol", "Beta-sitostanol", "Delta-5-avenasterol", "Phytosterols, other", 
	"Ergosta-7-enol", " Ergosta-7,22-dienol", " Ergosta-5,7-dienol", "Stigmastadiene", "Delta-7-Stigmastenol", "Daidzin", "Daidzein", "Genistein", "Genistin", "Glycitin")
	filter!(row -> !(row.name in non_relevant), nutrient_df)
	# Drop total fatty acids by labels
	filter!(row -> !occursin("NLEA", row.name), nutrient_df)
	# Drop specific forms of saturated fatty acids for keep only the total
	filter!(row -> !occursin("SFA", row.name), nutrient_df)
	# Drop specific forms of monounsaturated fatty acids for keep only the total
	filter!(row -> !occursin("MUFA", row.name), nutrient_df)
	# Drop specific forms of polyunsaturated fatty acids for keep only the total
	filter!(row -> !occursin("PUFA", row.name), nutrient_df)
	# Drop specific forms of Trans-fatty acids for keep only the total
	filter!(row -> !occursin("TFA", row.name), nutrient_df)
	unnecesary_trans = ("Fatty acids, total trans-monoenoic", "Fatty acids, total trans-dienoic", "Fatty acids, total trans-polyenoic")
	filter!(row -> !(row.name in unnecesary_trans), nutrient_df)
	# Keep only one total fiber measure per food
	have_fiber = Set(food_nutrient_df[food_nutrient_df.nutrient_id .== 1079, :fdc_id])
	have_AOAC_fiber = Set(food_nutrient_df[food_nutrient_df.nutrient_id .== 2033, :fdc_id])
	have_both_fiber = intersect(have_fiber, have_AOAC_fiber)
	have_both_fiber_condition(row) = ((row.nutrient_id == 2033) && (row.fdc_id in have_both_fiber)) || !(row.fdc_id in have_both_fiber)
	filter!(row -> have_both_fiber_condition(row), food_nutrient_df)
	food_nutrient_df[food_nutrient_df.nutrient_id .== 2033, :nutrient_id] .= 1079
	# Drop specific forms of fiber that are unnecesary
	unnecesary_fiber = ("High Molecular Weight Dietary Fiber (HMWDF)", "Low Molecular Weight Dietary Fiber (LMWDF)", "Total dietary fiber (AOAC 2011.25)", "Beta-glucan")
	filter!(row -> !(row.name in unnecesary_fiber), nutrient_df)
	# Keep only one energy measure per food
	have_energy_atwater = Set(food_nutrient_df[food_nutrient_df.nutrient_id .== 2047, :fdc_id])
	have_energy = Set(food_nutrient_df[food_nutrient_df.nutrient_id .== 1008, :fdc_id])
	have_both_energy = intersect(have_energy_atwater, have_energy)
	have_both_energy_condition(row) = ((row.nutrient_id == 2047) && (row.fdc_id in have_both_energy)) || !(row.fdc_id in have_both_energy)
	filter!(row -> have_both_energy_condition(row), food_nutrient_df)
	food_nutrient_df[food_nutrient_df.nutrient_id .== 2047, :nutrient_id] .= 1008
	# Drop energy measures not used
	unnecesary_energy = ("Energy (Atwater Specific Factors)", "Energy (Atwater General Factors)")
	filter!(row -> !(row.name in unnecesary_energy), nutrient_df)
	filter!(row -> !(row.id == 1062), nutrient_df)
	# Keep only one carbohydrate messure per food
	have_carbd = Set(food_nutrient_df[food_nutrient_df.nutrient_id .== 1005, :fdc_id])
	have_carbs = Set(food_nutrient_df[food_nutrient_df.nutrient_id .== 1050, :fdc_id])
	have_both_carb = intersect(have_carbd, have_carbs)
	have_both_carb_condition(row) = ((row.nutrient_id == 1050) && (row.fdc_id in have_both_energy)) || !(row.fdc_id in have_both_carb)
	filter!(row -> have_both_carb_condition(row), food_nutrient_df)
	food_nutrient_df[food_nutrient_df.nutrient_id .== 1005, :nutrient_id] .= 1050
	nutrient_df[nutrient_df.name .== "Carbohydrate, by summation", :name] .= "Carbohydrate, Total"
	# Drop carbohydrate measure not used
	filter!(row -> !(row.name == "Carbohydrate, by difference"), nutrient_df)
	# Drop specific forms of choline
	filter!(row -> !occursin("Choline", row.name) || row.name == "Choline, total", nutrient_df)
	# Drop unnecesary forms of vitamin E
	filter!(row -> !occursin("Toco", row.name), nutrient_df)
	nutrient_df[nutrient_df.name .== "Vitamin E (alpha-tocopherol)", :name] .= "Vitamin E"
	# Drop unnecesary forms of vitamin A and carotenoids
	unnecesary_vita = ("cis-beta-Carotene", "cis-Lycopene", "cis-Lutein/Zeaxanthin", "Carotene, beta", "Carotene, alpha", "Carotene, gamma", "trans-beta-Carotene", "trans-Lycopene", "Retinol", "Lutein", "Lycopene", "Lutein + zeaxanthin", "Cryptoxanthin, beta", "Cryptoxanthin, alpha", "Zeaxanthin", "Phytoene", "Phytofluene")
	filter!(row -> !(row.name in unnecesary_vita), nutrient_df)
	# Drop unnecesary forms of vitamin D
	unnecesary_vitd = ("25-hydroxycholecalciferol", "Vitamin D2 (ergocalciferol)", "Vitamin D3 (cholecalciferol)", "Vitamin D4")
	filter!(row -> !(row.name in unnecesary_vitd), nutrient_df)
	filter!(row -> !(row.id == 1110), nutrient_df)
	# Drop unnecesary forms of folate
	unnecesary_folate = ("5-methyl tetrahydrofolate (5-MTHF)", "10-Formyl folic acid (10HCOFA)", "5-Formyltetrahydrofolic acid (5-HCOH4")
	filter!(row -> !(row.name in unnecesary_folate), nutrient_df)
	# Drop unnecesary forms of sugar and oligosacarids
	unnecesary_sugar = ("Total Sugars", "Sucrose", "Glucose", "Maltose", "Fructose", "Lactose", "Galactose", "Raffinose", "Stachyose", "Verbascose")
	filter!(row -> !(row.name in unnecesary_sugar), nutrient_df)
	# Drop unnecesary forms of protein and aminoacids
	unnecesary_protein = ("Tryptophan", "Threonine", "Isoleucine", "Leucine", "Lysine", "Methionine", "Cystine", "Phenylalanine", "Tyrosine", "Valine", "Arginine", "Histidine", "Alanine", "Aspartic acid", "Glutamic acid", "Glycine", "Proline", "Serine", "Hydroxyproline", "Cysteine", "Ergothioneine", "Glutathione", "Betaine")
	filter!(row -> !(row.name in unnecesary_protein), nutrient_df)
	# Keep only food_nutrient_df entries that still have a match in nutrient_df
	food_nutrient_df = food_nutrient_df[in.(food_nutrient_df.nutrient_id, Ref(nutrient_df.id)), :]
	# Sort the data for convenience
	sort!(food_df, :description)
	sort!(food_nutrient_df, :fdc_id)
end

# ╔═╡ 4ec3acab-86ed-414d-b766-30bc475d46ea
size(food_df)

# ╔═╡ 970e74f3-2456-4064-863f-4e5476d21811
size(food_nutrient_df)

# ╔═╡ b4adc167-2150-4bda-a88f-5e3a48eaa682
size(nutrient_df)

# ╔═╡ 398c8fbe-8514-46aa-9567-b6e0564e6ea3
food_df

# ╔═╡ 1205cc0a-518c-4ac1-939c-75c9a94b7164
nutrient_df

# ╔═╡ 137e51e3-6a84-4006-a99f-c3cf5b548412
food_nutrient_df

# ╔═╡ a9e9ffd9-5967-41bc-b28a-d820ff19c958
begin
	merged_df = leftjoin(food_nutrient_df, nutrient_df, on=:nutrient_id => :id)
	merged_df = leftjoin(merged_df, food_df, on=:fdc_id)
	final_df = unstack(merged_df, [:fdc_id, :description], :name, :amount)
	for col in names(final_df)[2:end]
	    replace!(final_df[!, col], missing => 0)
	end
	final_df
	CSV.write(p"./data/final_nutrients.csv", final_df)
end

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
CSV = "336ed68f-0bac-5ca0-87d4-7b16caf5d00b"
DataFrames = "a93c6f00-e57d-5684-b7b6-d8193f3e46c0"
Dates = "ade2ca70-3891-5945-98fb-dc099432e06a"
FilePaths = "8fc22ac5-c921-52a6-82fd-178b2807b824"
FilePathsBase = "48062228-2e41-5def-b9a4-89aafe57970f"

[compat]
CSV = "~0.10.14"
DataFrames = "~1.6.1"
FilePaths = "~0.8.3"
FilePathsBase = "~0.9.21"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.10.4"
manifest_format = "2.0"
project_hash = "f0df1e517883fea5037594ca2659fb23b1b418d3"

[[deps.Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"

[[deps.Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"

[[deps.CSV]]
deps = ["CodecZlib", "Dates", "FilePathsBase", "InlineStrings", "Mmap", "Parsers", "PooledArrays", "PrecompileTools", "SentinelArrays", "Tables", "Unicode", "WeakRefStrings", "WorkerUtilities"]
git-tree-sha1 = "6c834533dc1fabd820c1db03c839bf97e45a3fab"
uuid = "336ed68f-0bac-5ca0-87d4-7b16caf5d00b"
version = "0.10.14"

[[deps.CodecZlib]]
deps = ["TranscodingStreams", "Zlib_jll"]
git-tree-sha1 = "b8fe8546d52ca154ac556809e10c75e6e7430ac8"
uuid = "944b1d66-785c-5afd-91f1-9de20f533193"
version = "0.7.5"

[[deps.Compat]]
deps = ["TOML", "UUIDs"]
git-tree-sha1 = "b1c55339b7c6c350ee89f2c1604299660525b248"
uuid = "34da2185-b29b-5c13-b0c7-acf172513d20"
version = "4.15.0"
weakdeps = ["Dates", "LinearAlgebra"]

    [deps.Compat.extensions]
    CompatLinearAlgebraExt = "LinearAlgebra"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"
version = "1.1.1+0"

[[deps.Crayons]]
git-tree-sha1 = "249fe38abf76d48563e2f4556bebd215aa317e15"
uuid = "a8cc5b0e-0ffa-5ad4-8c14-923d3ee1735f"
version = "4.1.1"

[[deps.DataAPI]]
git-tree-sha1 = "abe83f3a2f1b857aac70ef8b269080af17764bbe"
uuid = "9a962f9c-6df0-11e9-0e5d-c546b8b5ee8a"
version = "1.16.0"

[[deps.DataFrames]]
deps = ["Compat", "DataAPI", "DataStructures", "Future", "InlineStrings", "InvertedIndices", "IteratorInterfaceExtensions", "LinearAlgebra", "Markdown", "Missings", "PooledArrays", "PrecompileTools", "PrettyTables", "Printf", "REPL", "Random", "Reexport", "SentinelArrays", "SortingAlgorithms", "Statistics", "TableTraits", "Tables", "Unicode"]
git-tree-sha1 = "04c738083f29f86e62c8afc341f0967d8717bdb8"
uuid = "a93c6f00-e57d-5684-b7b6-d8193f3e46c0"
version = "1.6.1"

[[deps.DataStructures]]
deps = ["Compat", "InteractiveUtils", "OrderedCollections"]
git-tree-sha1 = "1d0a14036acb104d9e89698bd408f63ab58cdc82"
uuid = "864edb3b-99cc-5e75-8d2d-829cb0a9cfe8"
version = "0.18.20"

[[deps.DataValueInterfaces]]
git-tree-sha1 = "bfc1187b79289637fa0ef6d4436ebdfe6905cbd6"
uuid = "e2d170a0-9d28-54be-80f0-106bbe20a464"
version = "1.0.0"

[[deps.Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"

[[deps.FilePaths]]
deps = ["FilePathsBase", "MacroTools", "Reexport", "Requires"]
git-tree-sha1 = "919d9412dbf53a2e6fe74af62a73ceed0bce0629"
uuid = "8fc22ac5-c921-52a6-82fd-178b2807b824"
version = "0.8.3"

[[deps.FilePathsBase]]
deps = ["Compat", "Dates", "Mmap", "Printf", "Test", "UUIDs"]
git-tree-sha1 = "9f00e42f8d99fdde64d40c8ea5d14269a2e2c1aa"
uuid = "48062228-2e41-5def-b9a4-89aafe57970f"
version = "0.9.21"

[[deps.Future]]
deps = ["Random"]
uuid = "9fa8497b-333b-5362-9e8d-4d0656e87820"

[[deps.InlineStrings]]
deps = ["Parsers"]
git-tree-sha1 = "86356004f30f8e737eff143d57d41bd580e437aa"
uuid = "842dd82b-1e85-43dc-bf29-5d0ee9dffc48"
version = "1.4.1"

    [deps.InlineStrings.extensions]
    ArrowTypesExt = "ArrowTypes"

    [deps.InlineStrings.weakdeps]
    ArrowTypes = "31f734f8-188a-4ce0-8406-c8a06bd891cd"

[[deps.InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"

[[deps.InvertedIndices]]
git-tree-sha1 = "0dc7b50b8d436461be01300fd8cd45aa0274b038"
uuid = "41ab1584-1d38-5bbf-9106-f11c6c58b48f"
version = "1.3.0"

[[deps.IteratorInterfaceExtensions]]
git-tree-sha1 = "a3f24677c21f5bbe9d2a714f95dcd58337fb2856"
uuid = "82899510-4779-5014-852e-03e436cf321d"
version = "1.0.0"

[[deps.LaTeXStrings]]
git-tree-sha1 = "50901ebc375ed41dbf8058da26f9de442febbbec"
uuid = "b964fa9f-0449-5b57-a5c2-d3ea65f4040f"
version = "1.3.1"

[[deps.Libdl]]
uuid = "8f399da3-3557-5675-b5ff-fb832c97cbdb"

[[deps.LinearAlgebra]]
deps = ["Libdl", "OpenBLAS_jll", "libblastrampoline_jll"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"

[[deps.Logging]]
uuid = "56ddb016-857b-54e1-b83d-db4d58db5568"

[[deps.MacroTools]]
deps = ["Markdown", "Random"]
git-tree-sha1 = "2fa9ee3e63fd3a4f7a9a4f4744a52f4856de82df"
uuid = "1914dd2f-81c6-5fcd-8719-6d5c9610ff09"
version = "0.5.13"

[[deps.Markdown]]
deps = ["Base64"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"

[[deps.Missings]]
deps = ["DataAPI"]
git-tree-sha1 = "ec4f7fbeab05d7747bdf98eb74d130a2a2ed298d"
uuid = "e1d29d7a-bbdc-5cf2-9ac0-f12de2c33e28"
version = "1.2.0"

[[deps.Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"

[[deps.OpenBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "4536629a-c528-5b80-bd46-f80d51c5b363"
version = "0.3.23+4"

[[deps.OrderedCollections]]
git-tree-sha1 = "dfdf5519f235516220579f949664f1bf44e741c5"
uuid = "bac558e1-5e72-5ebc-8fee-abe8a469f55d"
version = "1.6.3"

[[deps.Parsers]]
deps = ["Dates", "PrecompileTools", "UUIDs"]
git-tree-sha1 = "8489905bcdbcfac64d1daa51ca07c0d8f0283821"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.8.1"

[[deps.PooledArrays]]
deps = ["DataAPI", "Future"]
git-tree-sha1 = "36d8b4b899628fb92c2749eb488d884a926614d3"
uuid = "2dfb63ee-cc39-5dd5-95bd-886bf059d720"
version = "1.4.3"

[[deps.PrecompileTools]]
deps = ["Preferences"]
git-tree-sha1 = "5aa36f7049a63a1528fe8f7c3f2113413ffd4e1f"
uuid = "aea7be01-6a6a-4083-8856-8a6e6704d82a"
version = "1.2.1"

[[deps.Preferences]]
deps = ["TOML"]
git-tree-sha1 = "9306f6085165d270f7e3db02af26a400d580f5c6"
uuid = "21216c6a-2e73-6563-6e65-726566657250"
version = "1.4.3"

[[deps.PrettyTables]]
deps = ["Crayons", "LaTeXStrings", "Markdown", "PrecompileTools", "Printf", "Reexport", "StringManipulation", "Tables"]
git-tree-sha1 = "66b20dd35966a748321d3b2537c4584cf40387c7"
uuid = "08abe8d2-0d0c-5749-adfa-8a2ac140af0d"
version = "2.3.2"

[[deps.Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"

[[deps.REPL]]
deps = ["InteractiveUtils", "Markdown", "Sockets", "Unicode"]
uuid = "3fa0cd96-eef1-5676-8a61-b3b8758bbffb"

[[deps.Random]]
deps = ["SHA"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"

[[deps.Reexport]]
git-tree-sha1 = "45e428421666073eab6f2da5c9d310d99bb12f9b"
uuid = "189a3867-3050-52da-a836-e630ba90ab69"
version = "1.2.2"

[[deps.Requires]]
deps = ["UUIDs"]
git-tree-sha1 = "838a3a4188e2ded87a4f9f184b4b0d78a1e91cb7"
uuid = "ae029012-a4dd-5104-9daa-d747884805df"
version = "1.3.0"

[[deps.SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"
version = "0.7.0"

[[deps.SentinelArrays]]
deps = ["Dates", "Random"]
git-tree-sha1 = "90b4f68892337554d31cdcdbe19e48989f26c7e6"
uuid = "91c51154-3ec4-41a3-a24f-3f23e20d615c"
version = "1.4.3"

[[deps.Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"

[[deps.Sockets]]
uuid = "6462fe0b-24de-5631-8697-dd941f90decc"

[[deps.SortingAlgorithms]]
deps = ["DataStructures"]
git-tree-sha1 = "66e0a8e672a0bdfca2c3f5937efb8538b9ddc085"
uuid = "a2af1166-a08f-5f64-846c-94a0d3cef48c"
version = "1.2.1"

[[deps.SparseArrays]]
deps = ["Libdl", "LinearAlgebra", "Random", "Serialization", "SuiteSparse_jll"]
uuid = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"
version = "1.10.0"

[[deps.Statistics]]
deps = ["LinearAlgebra", "SparseArrays"]
uuid = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"
version = "1.10.0"

[[deps.StringManipulation]]
deps = ["PrecompileTools"]
git-tree-sha1 = "a04cabe79c5f01f4d723cc6704070ada0b9d46d5"
uuid = "892a3eda-7b42-436c-8928-eab12a02cf0e"
version = "0.3.4"

[[deps.SuiteSparse_jll]]
deps = ["Artifacts", "Libdl", "libblastrampoline_jll"]
uuid = "bea87d4a-7f5b-5778-9afe-8cc45184846c"
version = "7.2.1+1"

[[deps.TOML]]
deps = ["Dates"]
uuid = "fa267f1f-6049-4f14-aa54-33bafae1ed76"
version = "1.0.3"

[[deps.TableTraits]]
deps = ["IteratorInterfaceExtensions"]
git-tree-sha1 = "c06b2f539df1c6efa794486abfb6ed2022561a39"
uuid = "3783bdb8-4a98-5b6b-af9a-565f29a5fe9c"
version = "1.0.1"

[[deps.Tables]]
deps = ["DataAPI", "DataValueInterfaces", "IteratorInterfaceExtensions", "LinearAlgebra", "OrderedCollections", "TableTraits"]
git-tree-sha1 = "cb76cf677714c095e535e3501ac7954732aeea2d"
uuid = "bd369af6-aec1-5ad0-b16a-f7cc5008161c"
version = "1.11.1"

[[deps.Test]]
deps = ["InteractiveUtils", "Logging", "Random", "Serialization"]
uuid = "8dfed614-e22c-5e08-85e1-65c5234f0b40"

[[deps.TranscodingStreams]]
git-tree-sha1 = "60df3f8126263c0d6b357b9a1017bb94f53e3582"
uuid = "3bb67fe8-82b1-5028-8e26-92a6c54297fa"
version = "0.11.0"
weakdeps = ["Random", "Test"]

    [deps.TranscodingStreams.extensions]
    TestExt = ["Test", "Random"]

[[deps.UUIDs]]
deps = ["Random", "SHA"]
uuid = "cf7118a7-6976-5b1a-9a39-7adc72f591a4"

[[deps.Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"

[[deps.WeakRefStrings]]
deps = ["DataAPI", "InlineStrings", "Parsers"]
git-tree-sha1 = "b1be2855ed9ed8eac54e5caff2afcdb442d52c23"
uuid = "ea10d353-3f73-51f8-a26c-33c1cb351aa5"
version = "1.4.2"

[[deps.WorkerUtilities]]
git-tree-sha1 = "cd1659ba0d57b71a464a29e64dbc67cfe83d54e7"
uuid = "76eceee3-57b5-4d4a-8e66-0e911cebbf60"
version = "1.6.1"

[[deps.Zlib_jll]]
deps = ["Libdl"]
uuid = "83775a58-1f1d-513f-b197-d71354ab007a"
version = "1.2.13+1"

[[deps.libblastrampoline_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850b90-86db-534c-a0d3-1478176c7d93"
version = "5.8.0+1"
"""

# ╔═╡ Cell order:
# ╠═1efe8035-b81c-4585-9b16-3e8e4838da3f
# ╠═fdd82160-411c-403f-ad37-577d48f07542
# ╠═26dffbb7-8892-46ec-838e-ddb05b4fd756
# ╠═4ec3acab-86ed-414d-b766-30bc475d46ea
# ╠═970e74f3-2456-4064-863f-4e5476d21811
# ╠═b4adc167-2150-4bda-a88f-5e3a48eaa682
# ╠═398c8fbe-8514-46aa-9567-b6e0564e6ea3
# ╠═1205cc0a-518c-4ac1-939c-75c9a94b7164
# ╠═137e51e3-6a84-4006-a99f-c3cf5b548412
# ╠═a9e9ffd9-5967-41bc-b28a-d820ff19c958
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
