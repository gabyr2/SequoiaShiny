## Setup
library(ggplot2)
library(plotly)
library(tidyverse)
library(lubridate)
library(scales) # viz
library(RColorBrewer) # viz

# For spatial work
library(sf)
library(mapview) # plotting
library(leafpop) # for customizing popups on maps
library(leaflet)

# For Shiny App
library(shiny)
library(shinydashboard)
# library(shinythemes)

## Read in data sets

# loggers
loggers <- readRDS(file = "D:/LocalRepos/SequoiaShiny/Data/hourlyLoggers.rds")

# USGS Marble Fork Kaweah NO3-N
usgs <- readRDS(file = "D:/LocalRepos/SequoiaShiny/Data/usgsStationWQ.rds")

# spatial
spatial <- read_csv(file = "D:/LocalRepos/SequoiaShiny/Data/lakeSpatialData.csv")

# secchi
secchi <- read_csv(file = "D:/LocalRepos/SequoiaShiny/Data/secchi.csv")

# YSI depth profiles
ysi <- read_csv(file = "D:/LocalRepos/SequoiaShiny/Data/YSI_Clean.csv")

# water chemistry & nutrients
watchem <- read_csv(file = "D:/LocalRepos/SequoiaShiny/Data/waterchem.csv")
watnutr <- read_csv(file = "D:/LocalRepos/SequoiaShiny/Data/waternutr.csv")

# sediment copper
sed <- read_csv(file = "D:/LocalRepos/SequoiaShiny/Data/sediment.csv")

# tadpoles morphology, copper, & histology
tad <- read_csv(file = "D:/LocalRepos/SequoiaShiny/Data/tadpole.csv")
histo <- read_csv(file = "D:/LocalRepos/SequoiaShiny/Data/histology.csv")

# periphyton chl.a, AFDM, & copper
per_chlafdm <- read_csv(file = "D:/LocalRepos/SequoiaShiny/Data/periChlaAfdm.csv")
per_cu <- read_csv(file = "D:/LocalRepos/SequoiaShiny/Data/periphytonCu.csv")



## Clean up data sets
loggers <- loggers %>%
  mutate(Location = as.factor(Location),
         Metric = as.factor(Metric))

usgs <- usgs %>%
  mutate(location = as.factor(location),
         units = as.factor(units))

spatial <- spatial %>%
  mutate(Location = as.factor(Location),
         Parameter = as.factor(Parameter),
         Statistic = as.factor(Statistic),
         Unit = as.factor(Unit))

secchi <- secchi %>% 
  mutate(Location = as.factor(Location),
         Year = as.factor(Year),
         Trip = as.factor(Trip),
         Date = parse_date(as.character(Date), format = "%Y%m%d"))

ysi <- ysi %>%
  mutate(Year = as.factor(Year),
         Trip = as.factor(Trip),
         Date = parse_date(as.character(Date), format = "%Y%m%d"),
         Location = as.factor(Location),
         Placement = as.factor(Placement),
         Metric = as.factor(Metric),
         Units = as.factor(Units))

watchem <- watchem %>%
  mutate(Date = parse_date(as.character(Date), format = "%Y%m%d"),
         Location = as.factor(Location),
         Section = as.factor(Section),
         Trip = as.factor(Trip), 
         Year = as.factor(Year),
         Sample_Type = as.factor(Sample_Type),
         Metric = as.factor(Metric),
         Units = as.factor(Units))

watnutr <- watnutr %>%
  mutate(Date = parse_date(as.character(Date), format = "%Y%m%d"),
         Location = as.factor(Location),
         Section = as.factor(Section),
         Trip = as.factor(Trip), 
         Year = as.factor(Year),
         Sample_Type = as.factor(Sample_Type),
         Metric = as.factor(Metric),
         Units = as.factor(Units))

sed <- sed %>%
  mutate(Date = parse_date(as.character(Date), format = "%Y%m%d"),
         Location = as.factor(Location),
         Trip = as.factor(Trip), 
         Year = as.factor(Year),
         Units = as.factor(Units))

tad <- tad %>%
  mutate(Date = parse_date(as.character(Date), format = "%Y%m%d"),
         Location = as.factor(Location),
         Trip = as.factor(Trip), 
         Year = as.factor(Year),
         Purpose = as.factor(Purpose),
         Bio_Deform = as.factor(Bio_Deform))

histo <- histo %>%
  mutate(Date = parse_date(as.character(Date), format = "%Y%m%d"),
         Location = as.factor(Location),
         Trip = as.factor(Trip), 
         Year = as.factor(Year),
         Stain = as.factor(Stain),
         CuClass = as.factor(CuClass),
         Hypereosin = as.factor(Hypereosin),
         Autolysis = as.factor(Autolysis),
         Vacuoliz = as.factor(Vacuoliz),
         Pancreas = as.factor(Pancreas),
         ExtraTiss = as.factor(ExtraTiss))

per_chlafdm <- per_chlafdm %>%
  mutate(Date = parse_date(as.character(Date), format = "%Y%m%d"),
         Location = as.factor(Location),
         Trip = as.factor(Trip), 
         Year = as.factor(Year),
         Metric = as.factor(Metric),
         Units = as.factor(Units))

per_cu <- per_cu %>%
  mutate(Date = parse_date(as.character(Date), format = "%Y%m%d"),
         Location = as.factor(Location),
         Trip = as.factor(Trip), 
         Year = as.factor(Year),
         Units = as.factor(Units))



## Shiny UI
header <- dashboardHeader(title = "USGS-NPS Water Quality Partnership Project Data",
                          titleWidth = 650)

sidebar <- dashboardSidebar(
  sidebarMenu(
    menuItem("About", tabName = "about", icon = icon("readme")),
    menuItem("Study Sites", tabName = "sites", icon = icon("map")),
    menuItem("Hourly Logger", tabName = "loggers", icon = icon("chart-line")),
    menuItem("Lake Depth Profiles", tabName = "profiles", icon = icon("anchor")),
    menuItem("Water Chemistry", tabName = "watchem", icon = icon("water")),
    menuItem("Copper", tabName = "copper", icon = icon("atom")),
    menuItem("Periphyton Growth", tabName = "peri", icon = icon("seedling")),
    menuItem("Tadpoles", tabName = "tadpoles", icon = icon("frog"))
  )
)

body <- dashboardBody(
  tabItems(
    # About
    tabItem(tabName = "about",
            fluidRow(
              column(12, h2("Description of the Dataset - View More at: doi:10.5066/P1T6UYAX"), 
                     p("This dataset includes a collection of files related to a project investigating the ecology of six lakes in the Tokopah Basin. The primary purpose of the research project was to understand the dynamics of periphyton growth and the potential relationships with nitrogen and copper concentrations in high elevation lakes of the Sierra Nevada mountains in Sequoia National Park, California. Additional research questions included those related to ecological variation between different lakes within the same basin, and those related to potential ecotoxicity of copper to organisms in these ecosystems. Files in this release contain data of lake depth profiles, lake watershed characteristics, Secchi depth, time series of specific parameters measured in study lakes and stream sites, water chemistry, sediment copper concentrations, periphyton copper concentrations and growth metrics (chlorophyll a and ash-free dry mass), and Pacific chorus frog tadpole (*Pseudacris regilla*) morphological characteristics, copper concentrations, and histological evaluations of liver tissue. The lake profile data includes measurements of dissolved oxygen, pH, temperature, conductivity, chlorophyll a, and phycocyanin at the surface, middle, and greatest depths of each lake and at each visit. Lake watershed data includes surface areas of the lakes and their watersheds, lake depths, summary statistics for elevation, slope, and aspect, and the proportions of each lake watershed covered by meadow, rock, upland, or other aquatic habitats. The time series data includes hourly measurements of temperature, conductivity, dissolved oxygen, pH, and nitrate at the six lake and two stream sites (nitrate only measured at the stream sites) for approximately April through November (specific timing varied by site and year). Water chemistry data includes concentration measurements of a variety of cations, anions, nutrients, dissolved organic matter, and copper. Tadpole morphological measurements include Gosner stage, mass, snout-vent length, total length, and the presence of deformities. Roughly half of all collected tadpoles were processed for whole-body copper concentration, and the other half had livers dissected for histological processing and evaluation.")),
              tags$img(src = "StudySiteMap_grats.png", alt = "site map",
                       height = "400px", weight = "900px", align = "center"))
    ),
    # sites
    tabItem(tabName = "sites",
            fluidRow(
              box(),
              box())
    ),
    # loggers
    tabItem(tabName = "loggers",
            fluidRow(
              box(),
              box())
    ),
    # profiles
    tabItem(tabName = "profiles",
            fluidRow(
              box(),
              box())
    ),
    # water chemistry
    tabItem(tabName = "watchem",
            fluidRow(
              box(),
              box())
    ),
    # copper
    tabItem(tabName = "copper",
            fluidRow(
              box(),
              box())
    ),
    # periphyton
    tabItem(tabName = "peri",
            fluidRow(
              box(),
              box())
    ),
    # tadpoles
    tabItem(tabName = "tadpoles",
            fluidRow(
              box(),
              box())
    )
  )
)



ui <- dashboardPage(header, sidebar, body)


## Server
server <- function(input, output){}


## Run App
shinyApp(ui, server)
