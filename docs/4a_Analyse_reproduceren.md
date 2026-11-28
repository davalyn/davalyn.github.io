

# Analyse reproduceren

## Data inlezen


``` r
data <- read_excel("data/CE.LIQ.FLOW.062_Tidydata.xlsx", sheet = "expParameters")
```

## Data inspecteren


``` r
head(data)
```

```
## # A tibble: 6 × 34
##   plateRow plateColumn vialNr dropCode expType    expReplicate expName        
##   <lgl>    <lgl>        <dbl> <chr>    <chr>             <dbl> <chr>          
## 1 NA       NA               1 a        experiment            3 CE.LIQ.FLOW.062
## 2 NA       NA               1 b        experiment            3 CE.LIQ.FLOW.062
## 3 NA       NA               1 c        experiment            3 CE.LIQ.FLOW.062
## 4 NA       NA               1 d        experiment            3 CE.LIQ.FLOW.062
## 5 NA       NA               1 e        experiment            3 CE.LIQ.FLOW.062
## 6 NA       NA               2 a        experiment            3 CE.LIQ.FLOW.062
## # ℹ 27 more variables: expDate <dttm>, expResearcher <chr>, expTime <dbl>,
## #   expUnit <chr>, expVolumeCounted <dbl>, RawData <dbl>, compCASRN <chr>,
## #   compName <chr>, compConcentration <chr>, compUnit <chr>,
## #   compDelivery <chr>, compVehicle <chr>, elegansStrain <chr>,
## #   elegansInput <dbl>, bacterialStrain <chr>, bacterialTreatment <chr>,
## #   bacterialOD600 <dbl>, bacterialConcX <dbl>, bacterialVolume <dbl>,
## #   bacterialVolUnit <chr>, incubationVial <chr>, incubationVolume <dbl>, …
```

## Scatterplot van de ruwe data


``` r
data$compConcentration <- as.numeric(data$compConcentration)

ggplot(data, aes(
  x = compConcentration, y = RawData,
  colour = compName, shape = expType)) +
  geom_point(position = position_jitter(width = 0.1, height = 0.5), alpha = 0.7) +
  scale_x_log10() +
  labs(x = "Concentration (log10)", y = "RawData",
    colour = "Chemical", shape = "Experiment type") +
  theme_bw()
```

<img src="4a_Analyse_reproduceren_files/figure-html/unnamed-chunk-3-1.png" alt="" width="672" />

## Data normaliseren


``` r
negative_mean <- mean(data$RawData[data$expType == "controlNegative"], na.rm = TRUE)

data$normalised <- data$RawData / negative_mean

mean(data$normalised[data$expType == "controlNegative"], na.rm = TRUE)
```

```
## [1] 1
```

## Scatterplot van de genormaliseerde data


``` r
ggplot(data, aes(x = compConcentration, y = normalised,
  colour = compName, shape = expType)) +
  geom_point(position = position_jitter(width = 0.1, height = 0.01), alpha = 0.7) +
  scale_x_log10() +
  labs(x = "Concentration (log10)", y = "Normalised RawData",
    colour = "Chemical", shape = "Experiment type") +
  theme_bw()
```

<img src="4a_Analyse_reproduceren_files/figure-html/unnamed-chunk-5-1.png" alt="" width="672" />

## Uitleg van de analyse

- De negatieve controle in dit experiment is S-medium zonder toegevoegde chemische stoffen. Dit dient als baseline om de normale voortplanting te meten. De positieve controle is ethanol en dient om te controleren of het experiment een bepaald effect kan aantonen.

- De negatieve controle geeft de normale situatie weer. De positieve controle laat zien of het experiment een effect kan detecteren. De vehicle control controleert of het oplosmiddel zelf invloed heeft op de resultaten.

- De normalisatie zorgt ervoor dat het gemiddelde van de negatieve controle gelijk wordt aan 1. Zo kunnen alle andere meetwaarden op een eerlijke manier worden vergeleken met de normale situatie.


## Stappenplan dose-response analyse

Voor vervolgonderzoek kan een dose-response analyse worden uitgevoerd om de IC50 te bepalen (met behulp van R-package `drc`)

1. Het package `drc` installeren.
2. Een chemische stof selecteren en de bijbehorende concentraties & waarden gebruiken
3. Een dose-response model maken met een log-logistisch model
4. De dose-response curve bekijken
5. IC50 berekenen.
