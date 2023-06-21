import json
import copy

inoqo_data = [
  ("4104420229761","Alnatura Hummus Natur",0.18,1.6,"B","X","B","B","alnatura-hummus-natur","alnatura-hummus-natur",230),
  ("4104420010642","Alnatura Rote Linsen",0.5,1.1,"A","X","B","A","alnatura-rote-linsen","alnatura-rote-linsen",362),
  ("4104420021921","Alnatura Haferflocken Feinblatt",1,0.7,"A","X","A","A","alnatura-haferflocken-feinblatt","alnatura-haferflocken-feinblatt",351),
  ("3073781106336","Babybel",0.1,7.4,"D","B","A","D","babybel","babybel",295),
  ("5410041001204","Tuc Original",0.1,1.9,"B","B","B","D","tuc-original","tuc-original",479),
  ("5000112547726","Coca-cola 1.5l",1.5,0.8,"A","X","B","E","coca-cola","coca-cola",38),
  ("5053990138722","Pringles Original",0.2,2.44,"B","X","B","D","pringles","pringles",534),
  ("8076809523509","Pasta",0.5,2.1,"B","X","B","A","spaghetti","spaghetti",359),
  ("4017100114717","Butterkeks",0.19,3.5,"C","D","B","C","butterkeks","butterkeks",445),
  ("4023900545507","Bamboo Garden coconut milk",0.4,1.2,"A","X","C","D","kokos-milk","kokos-milk",179),
  ("0000040737393","Himbeer",0.25,0.9,"A","X","B","X","himbeer","himbeer",66),
  ("4022269201352","Killepitsch",0.35,1.2,"A","X","A","X","killepitsch","killepitsch",248),
  ("8437003223068","Wine",0.75,1.12,"A","X","B","X","wine","wine",85),
  ("4023900261704","Bamboo Garden Wok-Oil",0.25,3.3,"C","X","C","D","wok-oil","wok-oil",828),
  ("8076800315097","Barilla noodles",0.5,2.1,"B","X","B","A","barilla-noodles","barilla-noodles",355),
  ("4011800524210","Corny Muesli Bars",0.15,3.5,"C","D","B","D","corny-muesli-bars","corny-muesli-bars",438),
  ("4002239422604","Dittmann Olives",0.085,1.9,"B","X","B","D","oliven","oliven",131),
  ("4018077620003","Lorentz Party Cracker",0.2,0.8,"A","D","B","D","lorentz-party-cracker","lorentz-party-cracker",481),
  ("4008100168039","ORO tomatoes",0.4,3,"B","X","A","B","tomaten-stuckig","tomaten-stuckig",23),
  ("4009300005230","Teekann Tea Sweet Kiss",0.1,4.2,"C","X","B","X","teekanne-tea-sweet-kiss","teekanne-tea-sweet-kiss",2)
]

template = {
  "operation": "updateOne",
  "filter": {"catalogName": "", "skuId": ""},
  "update": {
    "$set": {
      "description.de-DE": "",
      "displayName.de-DE": "",
      "images": [
        {
          "sizeCategory": "DEFAULT", 
          "url": ""
        },
        {
          "sizeCategory": "ECO-SCORE", 
          "url": ""
        },
        {
          "sizeCategory": "ECO-SCORE-MEDIUM", 
          "url": ""
        }
      ],
      "attributes": {
      },
    }
  },
}

items = []
for gtin,name,weight,kgCO2ePerKg,climateScore,animalWelfareScore,socialScore,nutritionScore,product_image,inoqo_image,calories in inoqo_data:
  item = copy.deepcopy(template)

  filter = item["filter"]
  filter["skuId"] = gtin
  filter["catalogName"] = "CATALOG_EU_HVR"

  set = item["update"]["$set"]
  set["description.de-DE"] = name
  set["displayName.de-DE"] = name

  images = set["images"]
  images[0]["url"] = f"/images/product/{product_image}.png"
  if inoqo_image:
    images[1]["url"] = f"/images/inoqo/small/{inoqo_image}.png"   # 23 pixels heigh for EU SCO theme
    images[2]["url"] = f"/images/inoqo/medium/{inoqo_image}.png"  # 40 pixels heigh for US SCO theme
  else:
    del images[1]
    del images[2]

  attributes = item["update"]["$set"]["attributes"]
  attributes["weight_in_kq"] = weight
  attributes["kg_co2_e_per_kg"] = kgCO2ePerKg
  attributes["climate_score"] = climateScore
  attributes["animal_welfare_score"] = animalWelfareScore
  attributes["social_score"] = socialScore
  attributes["nutrition_score"] = nutritionScore
  attributes["kcal_per_100g"] = calories

  items.append(item)

with open("tgcp_catalogs_items.json", "w") as outfile:
    outfile.write(json.dumps(items, indent=2))


#from barcode import EAN13
#from barcode.writer import ImageWriter
#from PIL import Image

#barcodes = []

#with open("barcode.jpeg", "wb") as f:
#  EAN13(gtin, writer=ImageWriter()).write(f)
#  image = Image.open("barcode.jpeg")
#  barcodes.append(image)

#barcodes[0].save("tgcp_catalogs_items.pdf", "PDF" ,resolution=100.0, save_all=True, append_images=barcodes[1:])
