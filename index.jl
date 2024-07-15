### A Pluto.jl notebook ###
# v0.19.43

using Markdown
using InteractiveUtils

# ╔═╡ 7fad7700-b3d6-4ebe-ae58-cf36fe4342ec
begin

	using PlutoUI
	using Combinatorics
	using Markdown
	using InteractiveUtils
	using PlotUtils
	using CSV
	using DataFrames
	using FilePaths
	using FilePathsBase
	using Dates
	using Convex
	using GLPK
	
    html"""
    <style>

	@import url('https://fonts.googleapis.com/css2?family=Didact+Gothic&display=swap');
	@import url('https://fonts.googleapis.com/css2?family=Didact+Gothic&family=Roboto+Serif:wght@400;700&display=swap');
	
    body {
        font-family: 'Arial', sans-serif;
        background-image: url('https://i.imgur.com/PqhZ7rK.png');
        background-size: cover; 
        background-repeat: no-repeat; 
        background-attachment: fixed; 
		color: #333;
    }

	pluto-output {
		background-color:#F7F5EA; 
	}


	pluto-output p {
		font-family: 'didact gothic', didact gothic;
		font-family #: 'didact gothic', didact gothic;
		font-size: 1.1em;
		background-color:#F7F5EA; 
	}

	pluto-output h1 {
		font-family: 'roboto serif', sans-serif;
		font-family #: 'roboto serif', sans-serif;
		font-size: 3.5em;
		font-weight: normal;
		background-color:#F7F5EA; 
	}
	
	pluto-output h2 {
		font-family: 'roboto serif', sans-serif;
		font-family #: 'roboto serif', sans-serif;
		font-size: 2.6em;
		font-weight: normal;
		background-color:#F7F5EA; 
	}

    </style>
    """
end


# ╔═╡ 9eb4b553-449b-4139-bfe3-951e7fa1b22a
md"""
# Optiet: Maximizando la Nutrición

Introdución a la optimización 

- Laura Valeria Pineda Martinez
- Pawell Steven Torres Gutierrez
- Jhonatan Alejandro Solano Mendoza
- Anderson Andres Llanos Quintero

Docente Juan Carlos Galvis Arrieta

Semestre 2024-1

---
"""

# ╔═╡ 69ad61ad-fbcb-4639-b6a0-cef4919c8e3d
md"""
# Introducción
## Objetivo del proyecto
Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla finibus, lectus vitae molestie imperdiet, elit velit porttitor lacus, nec sagittis velit sapien sit amet purus. Morbi fermentum condimentum metus, nec euismod erat bibendum et. Curabitur elementum non turpis et lacinia. Duis ac sapien posuere, congue sem in, aliquet orci. Fusce bibendum sed erat accumsan viverra. Nulla urna sapien, rutrum sollicitudin dignissim a, tristique ut odio. 
## Importancia de la planificación de dietas
Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla finibus, lectus vitae molestie imperdiet, elit velit porttitor lacus, nec sagittis velit sapien sit amet purus. Morbi fermentum condimentum metus, nec euismod erat bibendum et. Curabitur elementum non turpis et lacinia. Duis ac sapien posuere, congue sem in, aliquet orci. Fusce bibendum sed erat accumsan viverra. Nulla urna sapien, rutrum sollicitudin dignissim a, tristique ut odio. 
"""

# ╔═╡ f2bc6731-abf5-4f94-908c-038e3b1c2c8f
md"""
# Fundamentos teóricos
## Optimización convexa
Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla finibus, lectus vitae molestie imperdiet, elit velit porttitor lacus, nec sagittis velit sapien sit amet purus. Morbi fermentum condimentum metus, nec euismod erat bibendum et. Curabitur elementum non turpis et lacinia. Duis ac sapien posuere, congue sem in, aliquet orci. Fusce bibendum sed erat accumsan viverra. Nulla urna sapien, rutrum sollicitudin dignissim a, tristique ut odio. 
## Problema de la mochila binaria
Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla finibus, lectus vitae molestie imperdiet, elit velit porttitor lacus, nec sagittis velit sapien sit amet purus. Morbi fermentum condimentum metus, nec euismod erat bibendum et. Curabitur elementum non turpis et lacinia. Duis ac sapien posuere, congue sem in, aliquet orci. Fusce bibendum sed erat accumsan viverra. Nulla urna sapien, rutrum sollicitudin dignissim a, tristique ut odio. 
## Aplicación en la planificación de dietas
Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla finibus, lectus vitae molestie imperdiet, elit velit porttitor lacus, nec sagittis velit sapien sit amet purus. Morbi fermentum condimentum metus, nec euismod erat bibendum et. Curabitur elementum non turpis et lacinia. Duis ac sapien posuere, congue sem in, aliquet orci. Fusce bibendum sed erat accumsan viverra. Nulla urna sapien, rutrum sollicitudin dignissim a, tristique ut odio. 
"""

# ╔═╡ e558d92c-50f3-4985-a460-d3ac8667cde2
md"""
# Base de datos de alimentos
## Fuente de datos
Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla finibus, lectus vitae molestie imperdiet, elit velit porttitor lacus, nec sagittis velit sapien sit amet purus. Morbi fermentum condimentum metus, nec euismod erat bibendum et. Curabitur elementum non turpis et lacinia. Duis ac sapien posuere, congue sem in, aliquet orci. Fusce bibendum sed erat accumsan viverra. Nulla urna sapien, rutrum sollicitudin dignissim a, tristique ut odio. 
## Descripción de la base de datos
Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla finibus, lectus vitae molestie imperdiet, elit velit porttitor lacus, nec sagittis velit sapien sit amet purus. Morbi fermentum condimentum metus, nec euismod erat bibendum et. Curabitur elementum non turpis et lacinia. Duis ac sapien posuere, congue sem in, aliquet orci. Fusce bibendum sed erat accumsan viverra. Nulla urna sapien, rutrum sollicitudin dignissim a, tristique ut odio. 
## Estructura y contenidos
Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla finibus, lectus vitae molestie imperdiet, elit velit porttitor lacus, nec sagittis velit sapien sit amet purus. Morbi fermentum condimentum metus, nec euismod erat bibendum et. Curabitur elementum non turpis et lacinia. Duis ac sapien posuere, congue sem in, aliquet orci. Fusce bibendum sed erat accumsan viverra. Nulla urna sapien, rutrum sollicitudin dignissim a, tristique ut odio. 
"""

# ╔═╡ 77ec79fc-ecfc-45f7-a971-5334d6295bec
md"""
# Preparación de los datos
## Limpieza y transformación de los datos
Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla finibus, lectus vitae molestie imperdiet, elit velit porttitor lacus, nec sagittis velit sapien sit amet purus. Morbi fermentum condimentum metus, nec euismod erat bibendum et. Curabitur elementum non turpis et lacinia. Duis ac sapien posuere, congue sem in, aliquet orci. Fusce bibendum sed erat accumsan viverra. Nulla urna sapien, rutrum sollicitudin dignissim a, tristique ut odio. 
"""

# ╔═╡ f4973cb6-7d8d-4e4c-8594-aa28ea4db4c9
function filter_duplicated_by_date(df)
    if length(unique(df.publication_date)) == 1
        return df
    else
        sorted_df = sort(df, :publication_date, rev=true)
        most_recent_date = sorted_df[1, :publication_date]
        return filter(row -> row[:publication_date] == most_recent_date, df)
    end
end

# ╔═╡ 571340fa-1d50-4ad8-bbc1-d549c4314af2
function print_debug_info(df, fdc_id, nutrient_id)
    println("Checking for fdc_id = $fdc_id and nutrient_id = $nutrient_id")
    println(df[(df.fdc_id .== fdc_id) .& (df.nutrient_id .== nutrient_id), :])
end

# ╔═╡ fb57eed1-ebc1-40a8-893c-aa8c13430704
begin

	# Import all the raw data before processing
	food_path = p"data/FoodData_Central_foundation_food_csv_2024-04-18/food.csv"
	food_nutrient_path =
		p"data\FoodData_Central_foundation_food_csv_2024-04-18\food_nutrient.csv"
	nutrient_path = p"data\FoodData_Central_foundation_food_csv_2024-04-18\nutrient.csv"
	food_df = DataFrame(CSV.File(food_path))
	food_nutrient_df = DataFrame(CSV.File(food_nutrient_path))
	nutrient_df = DataFrame(CSV.File(nutrient_path))
	
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
	have_both_fiber_condition(row) = ((row.nutrient_id == 2033) && (row.fdc_id in have_both_fiber)) || !(row.fdc_id in have_both_fiber) || ((row.nutrient_id != 1079) && (row.nutrient_id != 2033))
	filter!(row -> have_both_fiber_condition(row), food_nutrient_df)
	food_nutrient_df[food_nutrient_df.nutrient_id .== 2033, :nutrient_id] .= 1079
	# Drop specific forms of fiber that are unnecesary
	unnecesary_fiber = ("High Molecular Weight Dietary Fiber (HMWDF)", "Low Molecular Weight Dietary Fiber (LMWDF)", "Total dietary fiber (AOAC 2011.25)", "Beta-glucan")
	filter!(row -> !(row.name in unnecesary_fiber), nutrient_df)
	
	# Keep only one energy measure per food
	have_energy_atwater = Set(food_nutrient_df[food_nutrient_df.nutrient_id .== 2047, :fdc_id])
	have_energy = Set(food_nutrient_df[food_nutrient_df.nutrient_id .== 1008, :fdc_id])
	have_both_energy = intersect(have_energy_atwater, have_energy)
	have_both_energy_condition(row) = ((row.nutrient_id == 2047) && (row.fdc_id in have_both_energy)) || !(row.fdc_id in have_both_energy) || ((row.nutrient_id != 1008) && (row.nutrient_id != 2047))
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
	have_both_carb_condition(row) = ((row.nutrient_id == 1050) && (row.fdc_id in have_both_carb)) || !(row.fdc_id in have_both_carb) || ((row.nutrient_id != 1005) && (row.nutrient_id != 1050))
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
	sort!(food_nutrient_df, :fdc_id);

end

# ╔═╡ 26b0178f-4b21-45ec-9a14-ec3287c1cd15
size(food_df)

# ╔═╡ 2b375ef0-564b-4cbc-8ad5-22085b353871
size(food_nutrient_df)

# ╔═╡ f8064417-a29e-46da-a724-43aa80428e88
size(nutrient_df)

# ╔═╡ 1a21a8df-ee98-403d-bffe-11ac16c7031e
food_df

# ╔═╡ ff72d23f-68bf-4990-ac40-ea4b62fd05aa
nutrient_df

# ╔═╡ 6e92d909-3ad7-44c3-a513-07dbae9147a5
food_nutrient_df

# ╔═╡ 9feefa44-dc47-474d-91ff-8238317145b9
begin
    # Merge dataframes
    merged_df = leftjoin(food_nutrient_df, nutrient_df, on=:nutrient_id => :id)
    merged_df = leftjoin(merged_df, food_df, on=:fdc_id)

    # Unstack merged dataframe
    final_df = unstack(merged_df, [:fdc_id, :description], :name, :amount)

    # Replace missing values with 0
    for col in names(final_df)[3:end]  # Start from the third column
        replace!(final_df[!, col], missing => 0)
    end

    # Sort nutrient columns alphabetically
    nutrient_cols = names(final_df)[3:end]
    nutrient_cols_sorted = sort(nutrient_cols)

    # Reorder dataframe columns
    new_cols = [:fdc_id, :description, "Energy", nutrient_cols_sorted...]

    # Convert column names to Symbols
    new_cols_sym = Symbol.(unique(new_cols))

    # Select and reorder columns in final_df
    final_df = final_df[:, new_cols_sym]

    # Write final dataframe to CSV
    CSV.write("./data/final_nutrients.csv", final_df)
end

# ╔═╡ 372158ba-546d-469b-8f1e-ebf23d08404a
final_df

# ╔═╡ f0bdc334-aa27-476e-8799-da2e6c4ac658
md"""
## Visualización de los datos
Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla finibus, lectus vitae molestie imperdiet, elit velit porttitor lacus, nec sagittis velit sapien sit amet purus. Morbi fermentum condimentum metus, nec euismod erat bibendum et. Curabitur elementum non turpis et lacinia. Duis ac sapien posuere, congue sem in, aliquet orci. Fusce bibendum sed erat accumsan viverra. Nulla urna sapien, rutrum sollicitudin dignissim a, tristique ut odio. 
"""

# ╔═╡ 0df52f9a-3f96-42b8-974d-afbb48e9cefd
md"""
# Modelo de optimización
## Definición de variables
Para esta sección, utilizaremos los paquetes Convex y GLPK que definimos en la primera celda, además de los que ya estábamos usando. Lo primero que haremos será cambiar el nombre de los datos de `final_df` a `alimentos_df`. Aunque este paso no es indispensable, hemos decidido hacerlo para facilitar la lectura del código.
"""

# ╔═╡ f38cf3f3-0cae-4594-9ea1-316ddea13ab1

alimentos_df = final_df

# ╔═╡ 725e2684-2b74-45cb-8daf-558f55d80328
md"""
Ahora definimos las variables de optimización $n$ y $x$. La variable $n$ representa la longitud del vector $x$, que en nuestro caso corresponde a la cantidad de alimentos que estamos analizando. Dado que en cada ejercicio podemos variar el número de alimentos considerados para nuestra dieta, planteamos $n$ de esta manera en lugar de usar un número fijo. Por otro lado, $x$ es el vector que definirá si cada alimento se incluye o no en la dieta, cada entrada de este vector es binaria donde 0 indica que el alimento no fue seleccionado para la dieta y 1 indica que sí fue seleccionado, siguiendo el ejemplo del problema del saco binario.
"""

# ╔═╡ 8599b308-f3e0-46ee-8c95-20f9bad6d821
begin 

for col in names(alimentos_df)
    alimentos_df[!, col] = coalesce.(alimentos_df[!, col], 0)
end

n = size(alimentos_df, 1)
x = Variable(n, BinVar) 
end

# ╔═╡ 8b7b550b-9879-401c-9122-068ac0cc5272
md"""
Después de esto, seleccionamos los 18 nutrientes específicos que deseamos analizar y asignamos los nombres correspondientes a cada una de las columnas en `alimentos_df`. Esto nos permite acceder a los datos relevantes de manera estructurada y clara.
"""

# ╔═╡ 7ac46500-67d3-4950-a324-8ea575640d37
begin
	calorias = alimentos_df[:, "Energy"]
	proteinas = alimentos_df[:, "Protein"]
	grasas = alimentos_df[:, "Total lipid (fat)"]
	carbohidratos = alimentos_df[:, "Carbohydrate, Total"]
	vitamina_a = alimentos_df[:, "Vitamin A, RAE"]
	vitamina_b12 = alimentos_df[:, "Vitamin B-12"]
	vitamina_b6 = alimentos_df[:, "Vitamin B-6"]
	vitamina_c = alimentos_df[:, "Vitamin C, total ascorbic acid"]
	vitamina_d = alimentos_df[:, "Vitamin D (D2 + D3)"]
	vitamina_e = alimentos_df[:, "Vitamin E"]
	vitamina_k = alimentos_df[:, "Vitamin K (Menaquinone-4)"]
	calcio = alimentos_df[:, "Calcium, Ca"]
	hierro = alimentos_df[:, "Iron, Fe"]
	magnesio = alimentos_df[:, "Magnesium, Mg"]
	fosforo = alimentos_df[:, "Phosphorus, P"]
	potasio = alimentos_df[:, "Potassium, K"]
	sodio = alimentos_df[:, "Sodium, Na"]
	zinc = alimentos_df[:, "Zinc, Zn"]
end

# ╔═╡ 7a521c99-7bcf-4bf4-8401-67de03e98567
md""" 
## Función objetivo y restricciones
En este punto, definimos la función objetivo, es decir, la que el solver va a maximizar. Excluimos las calorías y los carbohidratos de esta función, ya que, aunque son esenciales para la dieta, no son los elementos que deseamos maximizar directamente. Las calorías y los carbohidratos se han establecido en el paso anterior para controlar su cantidad total en la dieta optimizada, y para al final conocer cuanta es la ingesta de estos nutrientes.
"""

# ╔═╡ 7faa148d-ebf1-4cd0-8ad5-52ff8a50d6c7
begin

funcion_objetivo = sum(proteinas .* x) + sum(vitamina_a .* x) + sum(vitamina_b12 .* x) + sum(vitamina_b6 .* x) + sum(vitamina_c .* x) + 
                   sum(vitamina_d .* x) + sum(vitamina_e .* x) + sum(vitamina_k .* x) + sum(calcio .* x) + sum(hierro .* x) + 
                   sum(magnesio .* x) + sum(fosforo .* x) + sum(potasio .* x) + 
                   sum(zinc .* x)


restricciones = [
    sum(calorias .* x) <= 2500,          # Máximo de calorías
    sum(proteinas .* x) >= 50,           # Mínimo de proteínas
    sum(carbohidratos .* x) <= 300,      # Máximo de carbohidratos totales
    sum(vitamina_a .* x) >= 900,         # Mínimo de vitamina A
    sum(vitamina_b12 .* x) >= 2.4,       # Mínimo de vitamina B12
    sum(vitamina_b6 .* x) >= 1.3,        # Mínimo de vitamina B6
    sum(vitamina_c .* x) >= 90,          # Mínimo de vitamina C
    sum(vitamina_d .* x) >= 15,          # Mínimo de vitamina D
    sum(vitamina_e .* x) >= 100,         # Mínimo de vitamina E
    sum(vitamina_k .* x) >= 1,           # Mínimo de vitamina K
    sum(calcio .* x) >= 1000,            # Mínimo de calcio
    sum(hierro .* x) >= 8,               # Mínimo de hierro (puede ser 18 para mujeres)
    sum(magnesio .* x) >= 400,           # Mínimo de magnesio
    sum(fosforo .* x) >= 700,            # Mínimo de fósforo
    sum(potasio .* x) >= 4700,           # Mínimo de potasio
    sum(sodio .* x) <= 3000,             # Máximo de sodio
    sum(zinc .* x) >= 11,                # Mínimo de zinc (puede ser 8 para mujeres)
]

end

# ╔═╡ ac388665-512c-4532-84e6-4a63996927da
md"""
Con los 18 nutrientes y la función objetivo ya definidos, establecimos las restricciones del problema considerando las unidades de medida de cada nutriente y las recomendaciones de la USDA para los valores mínimos y máximos recomendados. Estas restricciones pueden ajustarse según las necesidades específicas de cada persona. Por ejemplo, para una persona con alta actividad física, el límite recomendado de calorías diarias puede aumentar de 2500 KCAL a un rango de 3000-3200 KCAL.
"""

# ╔═╡ d4c87336-138a-497f-9c91-e7cc13621782
md"""
## Solver utilizado
Utilizamos el solver GLPK (GNU Linear Programming Kit) junto con el paquete Convex.jl para resolver el problema de optimización de dietas. GLPK es un conjunto de rutinas escritas en C diseñadas para resolver problemas lineales y de programación entera mixta. Es ampliamente reconocido por su eficiencia y capacidad para manejar problemas grandes y complejos.

En este contexto, GLPK se utiliza para maximizar la función objetivo que considera la ingesta de diversos nutrientes mientras se cumplen las restricciones dietéticas. El solver trabaja iterativamente, ajustando las variables binarias que representan la selección de alimentos $x$ hasta encontrar la combinación óptima que maximiza los nutrientes deseados dentro de los límites calóricos y de otros nutrientes establecidos. 
"""

# ╔═╡ aafda15f-848f-42d5-8981-635292edb90b
begin

problema = maximize(funcion_objetivo, restricciones)

solve!(problema, GLPK.Optimizer)

porciones_seleccionadas = round.(Int, x.value)

end

# ╔═╡ 84d12eee-a8d9-4563-a58e-2b5b22b63b9e
md"""
# Resultados y análisis
## Visualización de resultados
Los resultados obtenidos del modelo de optimización proporcionan una lista detallada de los alimentos seleccionados (una porción de cada uno) y los valores totales de los 18 nutrientes clave en la dieta óptima. La selección de alimentos incluye una variedad de verduras, frutas, productos lácteos, carnes, aceites, hongos y legumbres, lo que asegura una dieta balanceada y rica en nutrientes.

La forma de visualización de estos resultados no solo facilita la interpretación y análisis del modelo, sino que también permite identificar áreas de mejora y ajustar las variables y restricciones para futuras optimizaciones. 
"""

# ╔═╡ 3638c32e-1c63-4c68-ad1e-3d5be01f785f
begin

# Imprimimos los alimentos seleccionados
println("Alimentos seleccionados para la dieta óptima:")
for i in 1:n
    if porciones_seleccionadas[i] > 0
        println("Alimento: ", alimentos_df[i, "description"])
    end
end

# Mostramos los totales de nutrientes en la dieta
println("Calorías totales: ", sum(calorias .* porciones_seleccionadas), " KCAL")
println("Proteínas totales: ", sum(proteinas .* porciones_seleccionadas), " G")
println("Carbohidratos totales: ", sum(carbohidratos .* porciones_seleccionadas), " G")
println("Grasas totales: ", sum(grasas .* porciones_seleccionadas), " G")
println("Vitamina A total: ", sum(vitamina_a .* porciones_seleccionadas), " UG")
println("Vitamina B12 total: ", sum(vitamina_b12 .* porciones_seleccionadas), " UG")
println("Vitamina B6 total: ", sum(vitamina_b6 .* porciones_seleccionadas), " MG")
println("Vitamina C total: ", sum(vitamina_c .* porciones_seleccionadas), " MG")
println("Vitamina D total: ", sum(vitamina_d .* porciones_seleccionadas), " IU")
println("Vitamina E total: ", sum(vitamina_e .* porciones_seleccionadas), " MG")
println("Vitamina K total: ", sum(vitamina_k .* porciones_seleccionadas), " UG")
println("Calcio total: ", sum(calcio .* porciones_seleccionadas), " MG")
println("Hierro total: ", sum(hierro .* porciones_seleccionadas), " MG")
println("Magnesio total: ", sum(magnesio .* porciones_seleccionadas), " MG")
println("Fósforo total: ", sum(fosforo .* porciones_seleccionadas), " MG")
println("Potasio total: ", sum(potasio .* porciones_seleccionadas), " MG")
println("Sodio total: ", sum(sodio .* porciones_seleccionadas), " MG")
println("Zinc total: ", sum(zinc .* porciones_seleccionadas), "MG")

end

# ╔═╡ c25a02f9-01ae-47b1-b8df-b808aba58207
md""" 
## Dieta óptima generada
El modelo ha logrado ajustar la ingesta total de calorías a aproximadamente 2500 KCAL, un valor muy cercano al límite establecido, lo que demuestra la eficacia del solver en cumplir las restricciones impuestas. Las proteínas alcanzan un valor total de 641.88 gramos, superando con creces el mínimo requerido, lo que garantiza un adecuado aporte proteico. Los carbohidratos se mantienen por debajo del límite máximo con 298.68 gramos, mientras que las grasas totales suman 228.78 gramos, asegurando una ingesta equilibrada de macronutrientes.

En cuanto a los micronutrientes, se observan valores sobresalientes, como los 2773.5 microgramos de vitamina A, 976.76 miligramos de vitamina C y 210.69 miligramos de vitamina E, todos los cuales superan ampliamente las necesidades diarias recomendadas. Los minerales también se encuentran en niveles óptimos, con 6479.19 miligramos de calcio, 128.65 miligramos de hierro y 4296.96 miligramos de magnesio. El potasio total asciende a 43007.16 miligramos, lo que asegura una adecuada función muscular y nerviosa, mientras que el sodio se mantiene dentro de los límites con 2908.07 miligramos. Finalmente, el zinc total se encuentra en 85.7 miligramos, cubriendo ampliamente los requerimientos diarios.

La diversidad de alimentos seleccionados y el cumplimiento de los límites nutricionales establecidos reflejan el éxito del modelo en generar una dieta balanceada y saludable.
"""

# ╔═╡ c8fac9d9-db20-4a04-b246-5e185123c149
md"""
# Conclusiones
## Resumen de hallazgos
Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla finibus, lectus vitae molestie imperdiet, elit velit porttitor lacus, nec sagittis velit sapien sit amet purus. Morbi fermentum condimentum metus, nec euismod erat bibendum et. Curabitur elementum non turpis et lacinia. Duis ac sapien posuere, congue sem in, aliquet orci. Fusce bibendum sed erat accumsan viverra. Nulla urna sapien, rutrum sollicitudin dignissim a, tristique ut odio. 
## Posibles mejoras y extensiones del proyecto
Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla finibus, lectus vitae molestie imperdiet, elit velit porttitor lacus, nec sagittis velit sapien sit amet purus. Morbi fermentum condimentum metus, nec euismod erat bibendum et. Curabitur elementum non turpis et lacinia. Duis ac sapien posuere, congue sem in, aliquet orci. Fusce bibendum sed erat accumsan viverra. Nulla urna sapien, rutrum sollicitudin dignissim a, tristique ut odio. 
"""

# ╔═╡ 50cfeca9-a617-424a-b2ea-44fcd538d918
md"""
# Referencias
## Bibliografía
Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla finibus, lectus vitae molestie imperdiet, elit velit porttitor lacus, nec sagittis velit sapien sit amet purus. Morbi fermentum condimentum metus, nec euismod erat bibendum et. Curabitur elementum non turpis et lacinia. Duis ac sapien posuere, congue sem in, aliquet orci. Fusce bibendum sed erat accumsan viverra. Nulla urna sapien, rutrum sollicitudin dignissim a, tristique ut odio. 
## Enlaces a recursos adicionales
Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla finibus, lectus vitae molestie imperdiet, elit velit porttitor lacus, nec sagittis velit sapien sit amet purus. Morbi fermentum condimentum metus, nec euismod erat bibendum et. Curabitur elementum non turpis et lacinia. Duis ac sapien posuere, congue sem in, aliquet orci. Fusce bibendum sed erat accumsan viverra. Nulla urna sapien, rutrum sollicitudin dignissim a, tristique ut odio. 
"""

# ╔═╡ 9fa50681-6b96-4cc2-bb84-a1aba8abeb8a
PlutoUI.TableOfContents(title="Contenido", aside=true)

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
CSV = "336ed68f-0bac-5ca0-87d4-7b16caf5d00b"
Combinatorics = "861a8166-3701-5b0c-9a16-15d98fcdc6aa"
Convex = "f65535da-76fb-5f13-bab9-19810c17039a"
DataFrames = "a93c6f00-e57d-5684-b7b6-d8193f3e46c0"
Dates = "ade2ca70-3891-5945-98fb-dc099432e06a"
FilePaths = "8fc22ac5-c921-52a6-82fd-178b2807b824"
FilePathsBase = "48062228-2e41-5def-b9a4-89aafe57970f"
GLPK = "60bf3e95-4087-53dc-ae20-288a0d20c6a6"
InteractiveUtils = "b77e0a4c-d291-57a0-90e8-8db25a27a240"
Markdown = "d6f4376e-aef5-505a-96c1-9c027394607a"
PlotUtils = "995b91a9-d308-5afd-9ec6-746e21dbc043"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"

[compat]
CSV = "~0.10.14"
Combinatorics = "~1.0.2"
Convex = "~0.16.2"
DataFrames = "~1.6.1"
FilePaths = "~0.8.3"
FilePathsBase = "~0.9.21"
GLPK = "~1.2.1"
PlotUtils = "~1.4.1"
PlutoUI = "~0.7.59"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.10.4"
manifest_format = "2.0"
project_hash = "7ff94ffa1377e973a671fb2e5ee5b5c39e45b114"

[[deps.AMD]]
deps = ["LinearAlgebra", "SparseArrays", "SuiteSparse_jll"]
git-tree-sha1 = "45a1272e3f809d36431e57ab22703c6896b8908f"
uuid = "14f7f29c-3bd6-536c-9a0b-7339e30b5a3e"
version = "0.5.3"

[[deps.AbstractPlutoDingetjes]]
deps = ["Pkg"]
git-tree-sha1 = "6e1d2a35f2f90a4bc7c2ed98079b2ba09c35b83a"
uuid = "6e696c72-6542-2067-7265-42206c756150"
version = "1.3.2"

[[deps.AbstractTrees]]
git-tree-sha1 = "2d9c9a55f9c93e8887ad391fbae72f8ef55e1177"
uuid = "1520ce14-60c1-5f80-bbc7-55ef81b5835c"
version = "0.4.5"

[[deps.ArgTools]]
uuid = "0dad84c5-d112-42e6-8d28-ef12dabb789f"
version = "1.1.1"

[[deps.Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"

[[deps.Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"

[[deps.BenchmarkTools]]
deps = ["JSON", "Logging", "Printf", "Profile", "Statistics", "UUIDs"]
git-tree-sha1 = "f1dff6729bc61f4d49e140da1af55dcd1ac97b2f"
uuid = "6e4b80f9-dd63-53aa-95a3-0cdb28fa8baf"
version = "1.5.0"

[[deps.Bzip2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "9e2a6b69137e6969bab0152632dcb3bc108c8bdd"
uuid = "6e34b625-4abd-537c-b88f-471c36dfa7a0"
version = "1.0.8+1"

[[deps.CSV]]
deps = ["CodecZlib", "Dates", "FilePathsBase", "InlineStrings", "Mmap", "Parsers", "PooledArrays", "PrecompileTools", "SentinelArrays", "Tables", "Unicode", "WeakRefStrings", "WorkerUtilities"]
git-tree-sha1 = "6c834533dc1fabd820c1db03c839bf97e45a3fab"
uuid = "336ed68f-0bac-5ca0-87d4-7b16caf5d00b"
version = "0.10.14"

[[deps.CodecBzip2]]
deps = ["Bzip2_jll", "Libdl", "TranscodingStreams"]
git-tree-sha1 = "f8889d1770addf59d0a015c49a473fa2bdb9f809"
uuid = "523fee87-0ab8-5b00-afb7-3ecf72e48cfd"
version = "0.8.3"

[[deps.CodecZlib]]
deps = ["TranscodingStreams", "Zlib_jll"]
git-tree-sha1 = "b8fe8546d52ca154ac556809e10c75e6e7430ac8"
uuid = "944b1d66-785c-5afd-91f1-9de20f533193"
version = "0.7.5"

[[deps.ColorSchemes]]
deps = ["ColorTypes", "ColorVectorSpace", "Colors", "FixedPointNumbers", "PrecompileTools", "Random"]
git-tree-sha1 = "4b270d6465eb21ae89b732182c20dc165f8bf9f2"
uuid = "35d6a980-a343-548e-a6ea-1d62b119f2f4"
version = "3.25.0"

[[deps.ColorTypes]]
deps = ["FixedPointNumbers", "Random"]
git-tree-sha1 = "b10d0b65641d57b8b4d5e234446582de5047050d"
uuid = "3da002f7-5984-5a60-b8a6-cbb66c0b333f"
version = "0.11.5"

[[deps.ColorVectorSpace]]
deps = ["ColorTypes", "FixedPointNumbers", "LinearAlgebra", "Requires", "Statistics", "TensorCore"]
git-tree-sha1 = "a1f44953f2382ebb937d60dafbe2deea4bd23249"
uuid = "c3611d14-8923-5661-9e6a-0046d554d3a4"
version = "0.10.0"
weakdeps = ["SpecialFunctions"]

    [deps.ColorVectorSpace.extensions]
    SpecialFunctionsExt = "SpecialFunctions"

[[deps.Colors]]
deps = ["ColorTypes", "FixedPointNumbers", "Reexport"]
git-tree-sha1 = "362a287c3aa50601b0bc359053d5c2468f0e7ce0"
uuid = "5ae59095-9a9b-59fe-a467-6f913c188581"
version = "0.12.11"

[[deps.Combinatorics]]
git-tree-sha1 = "08c8b6831dc00bfea825826be0bc8336fc369860"
uuid = "861a8166-3701-5b0c-9a16-15d98fcdc6aa"
version = "1.0.2"

[[deps.CommonSubexpressions]]
deps = ["MacroTools", "Test"]
git-tree-sha1 = "7b8a93dba8af7e3b42fecabf646260105ac373f7"
uuid = "bbf7d656-a473-5ed7-a52c-81e309532950"
version = "0.3.0"

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

[[deps.Convex]]
deps = ["AbstractTrees", "BenchmarkTools", "LDLFactorizations", "LinearAlgebra", "MathOptInterface", "OrderedCollections", "SparseArrays", "Test"]
git-tree-sha1 = "aee723f099f0bb8f7543573227fa90ee8cf4a25e"
uuid = "f65535da-76fb-5f13-bab9-19810c17039a"
version = "0.16.2"

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

[[deps.DiffResults]]
deps = ["StaticArraysCore"]
git-tree-sha1 = "782dd5f4561f5d267313f23853baaaa4c52ea621"
uuid = "163ba53b-c6d8-5494-b064-1a9d43ac40c5"
version = "1.1.0"

[[deps.DiffRules]]
deps = ["IrrationalConstants", "LogExpFunctions", "NaNMath", "Random", "SpecialFunctions"]
git-tree-sha1 = "23163d55f885173722d1e4cf0f6110cdbaf7e272"
uuid = "b552c78f-8df3-52c6-915a-8e097449b14b"
version = "1.15.1"

[[deps.DocStringExtensions]]
deps = ["LibGit2"]
git-tree-sha1 = "2fb1e02f2b635d0845df5d7c167fec4dd739b00d"
uuid = "ffbed154-4ef7-542d-bbb7-c09d3a79fcae"
version = "0.9.3"

[[deps.Downloads]]
deps = ["ArgTools", "FileWatching", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"
version = "1.6.0"

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

[[deps.FileWatching]]
uuid = "7b1f6079-737a-58dc-b8bc-7a2ca5c1b5ee"

[[deps.FixedPointNumbers]]
deps = ["Statistics"]
git-tree-sha1 = "05882d6995ae5c12bb5f36dd2ed3f61c98cbb172"
uuid = "53c48c17-4a7d-5ca2-90c5-79b7896eea93"
version = "0.8.5"

[[deps.ForwardDiff]]
deps = ["CommonSubexpressions", "DiffResults", "DiffRules", "LinearAlgebra", "LogExpFunctions", "NaNMath", "Preferences", "Printf", "Random", "SpecialFunctions"]
git-tree-sha1 = "cf0fe81336da9fb90944683b8c41984b08793dad"
uuid = "f6369f11-7733-5829-9624-2563aa707210"
version = "0.10.36"

    [deps.ForwardDiff.extensions]
    ForwardDiffStaticArraysExt = "StaticArrays"

    [deps.ForwardDiff.weakdeps]
    StaticArrays = "90137ffa-7385-5640-81b9-e52037218182"

[[deps.Future]]
deps = ["Random"]
uuid = "9fa8497b-333b-5362-9e8d-4d0656e87820"

[[deps.GLPK]]
deps = ["GLPK_jll", "MathOptInterface"]
git-tree-sha1 = "1d706bd23e5d2d407bfd369499ee6f96afb0c3ad"
uuid = "60bf3e95-4087-53dc-ae20-288a0d20c6a6"
version = "1.2.1"

[[deps.GLPK_jll]]
deps = ["Artifacts", "GMP_jll", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "fe68622f32828aa92275895fdb324a85894a5b1b"
uuid = "e8aa6df9-e6ca-548a-97ff-1f85fc5b8b98"
version = "5.0.1+0"

[[deps.GMP_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "781609d7-10c4-51f6-84f2-b8444358ff6d"
version = "6.2.1+6"

[[deps.Hyperscript]]
deps = ["Test"]
git-tree-sha1 = "179267cfa5e712760cd43dcae385d7ea90cc25a4"
uuid = "47d2ed2b-36de-50cf-bf87-49c2cf4b8b91"
version = "0.0.5"

[[deps.HypertextLiteral]]
deps = ["Tricks"]
git-tree-sha1 = "7134810b1afce04bbc1045ca1985fbe81ce17653"
uuid = "ac1192a8-f4b3-4bfe-ba22-af5b92cd3ab2"
version = "0.9.5"

[[deps.IOCapture]]
deps = ["Logging", "Random"]
git-tree-sha1 = "b6d6bfdd7ce25b0f9b2f6b3dd56b2673a66c8770"
uuid = "b5f81e59-6552-4d32-b1f0-c071b021bf89"
version = "0.2.5"

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

[[deps.IrrationalConstants]]
git-tree-sha1 = "630b497eafcc20001bba38a4651b327dcfc491d2"
uuid = "92d709cd-6900-40b7-9082-c6be49f344b6"
version = "0.2.2"

[[deps.IteratorInterfaceExtensions]]
git-tree-sha1 = "a3f24677c21f5bbe9d2a714f95dcd58337fb2856"
uuid = "82899510-4779-5014-852e-03e436cf321d"
version = "1.0.0"

[[deps.JLLWrappers]]
deps = ["Artifacts", "Preferences"]
git-tree-sha1 = "7e5d6779a1e09a36db2a7b6cff50942a0a7d0fca"
uuid = "692b3bcd-3c85-4b1f-b108-f13ce0eb3210"
version = "1.5.0"

[[deps.JSON]]
deps = ["Dates", "Mmap", "Parsers", "Unicode"]
git-tree-sha1 = "31e996f0a15c7b280ba9f76636b3ff9e2ae58c9a"
uuid = "682c06a0-de6a-54ab-a142-c8b1cf79cde6"
version = "0.21.4"

[[deps.LDLFactorizations]]
deps = ["AMD", "LinearAlgebra", "SparseArrays", "Test"]
git-tree-sha1 = "70f582b446a1c3ad82cf87e62b878668beef9d13"
uuid = "40e66cde-538c-5869-a4ad-c39174c6795b"
version = "0.10.1"

[[deps.LaTeXStrings]]
git-tree-sha1 = "50901ebc375ed41dbf8058da26f9de442febbbec"
uuid = "b964fa9f-0449-5b57-a5c2-d3ea65f4040f"
version = "1.3.1"

[[deps.LibCURL]]
deps = ["LibCURL_jll", "MozillaCACerts_jll"]
uuid = "b27032c2-a3e7-50c8-80cd-2d36dbcbfd21"
version = "0.6.4"

[[deps.LibCURL_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "MbedTLS_jll", "Zlib_jll", "nghttp2_jll"]
uuid = "deac9b47-8bc7-5906-a0fe-35ac56dc84c0"
version = "8.4.0+0"

[[deps.LibGit2]]
deps = ["Base64", "LibGit2_jll", "NetworkOptions", "Printf", "SHA"]
uuid = "76f85450-5226-5b5a-8eaa-529ad045b433"

[[deps.LibGit2_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "MbedTLS_jll"]
uuid = "e37daf67-58a4-590a-8e99-b0245dd2ffc5"
version = "1.6.4+0"

[[deps.LibSSH2_jll]]
deps = ["Artifacts", "Libdl", "MbedTLS_jll"]
uuid = "29816b5a-b9ab-546f-933c-edad1886dfa8"
version = "1.11.0+1"

[[deps.Libdl]]
uuid = "8f399da3-3557-5675-b5ff-fb832c97cbdb"

[[deps.LinearAlgebra]]
deps = ["Libdl", "OpenBLAS_jll", "libblastrampoline_jll"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"

[[deps.LogExpFunctions]]
deps = ["DocStringExtensions", "IrrationalConstants", "LinearAlgebra"]
git-tree-sha1 = "a2d09619db4e765091ee5c6ffe8872849de0feea"
uuid = "2ab3a3ac-af41-5b50-aa03-7779005ae688"
version = "0.3.28"

    [deps.LogExpFunctions.extensions]
    LogExpFunctionsChainRulesCoreExt = "ChainRulesCore"
    LogExpFunctionsChangesOfVariablesExt = "ChangesOfVariables"
    LogExpFunctionsInverseFunctionsExt = "InverseFunctions"

    [deps.LogExpFunctions.weakdeps]
    ChainRulesCore = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
    ChangesOfVariables = "9e997f8a-9a97-42d5-a9f1-ce6bfc15e2c0"
    InverseFunctions = "3587e190-3f89-42d0-90ee-14403ec27112"

[[deps.Logging]]
uuid = "56ddb016-857b-54e1-b83d-db4d58db5568"

[[deps.MIMEs]]
git-tree-sha1 = "65f28ad4b594aebe22157d6fac869786a255b7eb"
uuid = "6c6e2e6c-3030-632d-7369-2d6c69616d65"
version = "0.1.4"

[[deps.MacroTools]]
deps = ["Markdown", "Random"]
git-tree-sha1 = "2fa9ee3e63fd3a4f7a9a4f4744a52f4856de82df"
uuid = "1914dd2f-81c6-5fcd-8719-6d5c9610ff09"
version = "0.5.13"

[[deps.Markdown]]
deps = ["Base64"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"

[[deps.MathOptInterface]]
deps = ["BenchmarkTools", "CodecBzip2", "CodecZlib", "DataStructures", "ForwardDiff", "JSON", "LinearAlgebra", "MutableArithmetics", "NaNMath", "OrderedCollections", "PrecompileTools", "Printf", "SparseArrays", "SpecialFunctions", "Test", "Unicode"]
git-tree-sha1 = "91b08d27a27d83cf1e63e50837403e7f53a0fd74"
uuid = "b8f27783-ece8-5eb3-8dc8-9495eed66fee"
version = "1.31.0"

[[deps.MbedTLS_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "c8ffd9c3-330d-5841-b78e-0817d7145fa1"
version = "2.28.2+1"

[[deps.Missings]]
deps = ["DataAPI"]
git-tree-sha1 = "ec4f7fbeab05d7747bdf98eb74d130a2a2ed298d"
uuid = "e1d29d7a-bbdc-5cf2-9ac0-f12de2c33e28"
version = "1.2.0"

[[deps.Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"

[[deps.MozillaCACerts_jll]]
uuid = "14a3606d-f60d-562e-9121-12d972cd8159"
version = "2023.1.10"

[[deps.MutableArithmetics]]
deps = ["LinearAlgebra", "SparseArrays", "Test"]
git-tree-sha1 = "898c56fbf8bf71afb0c02146ef26f3a454e88873"
uuid = "d8a4904e-b15c-11e9-3269-09a3773c0cb0"
version = "1.4.5"

[[deps.NaNMath]]
deps = ["OpenLibm_jll"]
git-tree-sha1 = "0877504529a3e5c3343c6f8b4c0381e57e4387e4"
uuid = "77ba4419-2d1f-58cd-9bb1-8ffee604a2e3"
version = "1.0.2"

[[deps.NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"
version = "1.2.0"

[[deps.OpenBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "4536629a-c528-5b80-bd46-f80d51c5b363"
version = "0.3.23+4"

[[deps.OpenLibm_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "05823500-19ac-5b8b-9628-191a04bc5112"
version = "0.8.1+2"

[[deps.OpenSpecFun_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "13652491f6856acfd2db29360e1bbcd4565d04f1"
uuid = "efe28fd5-8261-553b-a9e1-b2916fc3738e"
version = "0.5.5+0"

[[deps.OrderedCollections]]
git-tree-sha1 = "dfdf5519f235516220579f949664f1bf44e741c5"
uuid = "bac558e1-5e72-5ebc-8fee-abe8a469f55d"
version = "1.6.3"

[[deps.Parsers]]
deps = ["Dates", "PrecompileTools", "UUIDs"]
git-tree-sha1 = "8489905bcdbcfac64d1daa51ca07c0d8f0283821"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.8.1"

[[deps.Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "FileWatching", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "REPL", "Random", "SHA", "Serialization", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"
version = "1.10.0"

[[deps.PlotUtils]]
deps = ["ColorSchemes", "Colors", "Dates", "PrecompileTools", "Printf", "Random", "Reexport", "Statistics"]
git-tree-sha1 = "7b1a9df27f072ac4c9c7cbe5efb198489258d1f5"
uuid = "995b91a9-d308-5afd-9ec6-746e21dbc043"
version = "1.4.1"

[[deps.PlutoUI]]
deps = ["AbstractPlutoDingetjes", "Base64", "ColorTypes", "Dates", "FixedPointNumbers", "Hyperscript", "HypertextLiteral", "IOCapture", "InteractiveUtils", "JSON", "Logging", "MIMEs", "Markdown", "Random", "Reexport", "URIs", "UUIDs"]
git-tree-sha1 = "ab55ee1510ad2af0ff674dbcced5e94921f867a9"
uuid = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
version = "0.7.59"

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

[[deps.Profile]]
deps = ["Printf"]
uuid = "9abbd945-dff8-562f-b5e8-e1ebf5ef1b79"

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

[[deps.SpecialFunctions]]
deps = ["IrrationalConstants", "LogExpFunctions", "OpenLibm_jll", "OpenSpecFun_jll"]
git-tree-sha1 = "2f5d4697f21388cbe1ff299430dd169ef97d7e14"
uuid = "276daf66-3868-5448-9aa4-cd146d93841b"
version = "2.4.0"

    [deps.SpecialFunctions.extensions]
    SpecialFunctionsChainRulesCoreExt = "ChainRulesCore"

    [deps.SpecialFunctions.weakdeps]
    ChainRulesCore = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"

[[deps.StaticArraysCore]]
git-tree-sha1 = "192954ef1208c7019899fbf8049e717f92959682"
uuid = "1e83bf80-4336-4d27-bf5d-d5a4f845583c"
version = "1.4.3"

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

[[deps.Tar]]
deps = ["ArgTools", "SHA"]
uuid = "a4e569a6-e804-4fa4-b0f3-eef7a1d5b13e"
version = "1.10.0"

[[deps.TensorCore]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "1feb45f88d133a655e001435632f019a9a1bcdb6"
uuid = "62fd8b95-f654-4bbd-a8a5-9c27f68ccd50"
version = "0.1.1"

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

[[deps.Tricks]]
git-tree-sha1 = "eae1bb484cd63b36999ee58be2de6c178105112f"
uuid = "410a4b4d-49e4-4fbc-ab6d-cb71b17b3775"
version = "0.1.8"

[[deps.URIs]]
git-tree-sha1 = "67db6cc7b3821e19ebe75791a9dd19c9b1188f2b"
uuid = "5c2747f8-b7ea-4ff2-ba2e-563bfd36b1d4"
version = "1.5.1"

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

[[deps.nghttp2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850ede-7688-5339-a07c-302acd2aaf8d"
version = "1.52.0+1"

[[deps.p7zip_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "3f19e933-33d8-53b3-aaab-bd5110c3b7a0"
version = "17.4.0+2"
"""

# ╔═╡ Cell order:
# ╟─7fad7700-b3d6-4ebe-ae58-cf36fe4342ec
# ╟─9eb4b553-449b-4139-bfe3-951e7fa1b22a
# ╟─69ad61ad-fbcb-4639-b6a0-cef4919c8e3d
# ╟─f2bc6731-abf5-4f94-908c-038e3b1c2c8f
# ╟─e558d92c-50f3-4985-a460-d3ac8667cde2
# ╟─77ec79fc-ecfc-45f7-a971-5334d6295bec
# ╟─f4973cb6-7d8d-4e4c-8594-aa28ea4db4c9
# ╟─571340fa-1d50-4ad8-bbc1-d549c4314af2
# ╠═fb57eed1-ebc1-40a8-893c-aa8c13430704
# ╟─26b0178f-4b21-45ec-9a14-ec3287c1cd15
# ╟─2b375ef0-564b-4cbc-8ad5-22085b353871
# ╟─f8064417-a29e-46da-a724-43aa80428e88
# ╠═1a21a8df-ee98-403d-bffe-11ac16c7031e
# ╟─ff72d23f-68bf-4990-ac40-ea4b62fd05aa
# ╟─6e92d909-3ad7-44c3-a513-07dbae9147a5
# ╟─9feefa44-dc47-474d-91ff-8238317145b9
# ╠═372158ba-546d-469b-8f1e-ebf23d08404a
# ╟─f0bdc334-aa27-476e-8799-da2e6c4ac658
# ╟─0df52f9a-3f96-42b8-974d-afbb48e9cefd
# ╠═f38cf3f3-0cae-4594-9ea1-316ddea13ab1
# ╟─725e2684-2b74-45cb-8daf-558f55d80328
# ╠═8599b308-f3e0-46ee-8c95-20f9bad6d821
# ╟─8b7b550b-9879-401c-9122-068ac0cc5272
# ╠═7ac46500-67d3-4950-a324-8ea575640d37
# ╟─7a521c99-7bcf-4bf4-8401-67de03e98567
# ╟─7faa148d-ebf1-4cd0-8ad5-52ff8a50d6c7
# ╟─ac388665-512c-4532-84e6-4a63996927da
# ╟─d4c87336-138a-497f-9c91-e7cc13621782
# ╠═aafda15f-848f-42d5-8981-635292edb90b
# ╟─84d12eee-a8d9-4563-a58e-2b5b22b63b9e
# ╟─3638c32e-1c63-4c68-ad1e-3d5be01f785f
# ╟─c25a02f9-01ae-47b1-b8df-b808aba58207
# ╟─c8fac9d9-db20-4a04-b246-5e185123c149
# ╟─50cfeca9-a617-424a-b2ea-44fcd538d918
# ╟─9fa50681-6b96-4cc2-bb84-a1aba8abeb8a
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
