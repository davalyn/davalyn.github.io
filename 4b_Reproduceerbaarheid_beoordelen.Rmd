# Reproduceerbaarheid beoordelen

## Artikel

Marinos et al. (2020). *Defining the nutritional input for genome-scale metabolic models: A roadmap.*

[Artikel](https://doi.org/10.1371/journal.pone.0236890) | [GitHub-repository](https://github.com/maringos/StepDiet)

### Onderzoeksvraag

Hoe kan de voedingssamenstelling van een groeimedium nauwkeurig worden vertaald naar invoergegevens voor genome-scale metabolic models?

### Methode en resultaten

De onderzoekers ontwikkelden een stappenplan met E. coli en LB medium. Met R analyseerden ze de voedingssamenstelling en voorspelden ze de bacteriële groei. De resultaten laten zien dat verschillende voedingsstoffen, zoals aminozuren en koolhydraten invloed hebben op de voorspelde groei.


## Transparantiecriteria

| Criterium | Beoordeling | Toelichting |
|---|---|---|
| Study Purpose | Ja | Het onderzoeksdoel is duidelijk beschreven. |
| Data Availability Statement | Ja | Er is een aparte verklaring over de beschikbaarheid van data. |
| Data Location | GitHub | Data en R-scripts zijn beschikbaar op GitHub |
| Study Location | Nee | Er wordt nergens een specifieke locatie vermeld. |
| Author Review | Ja | De auteurs vermelden hun e-mailadressen. |
| Ethics Statement | Nee | Er is geen aparte ethische verklaring opgenomen. |
| Funding Statement | Ja | De financiering van de Deutsche Forschungsgemeinschaft wordt vermeld. |
| Code Availability | Ja | De R-scripts zijn openbaar beschikbaar op GitHub. |


## Beoordeling van de R-code

### Beschrijving van de code

De R-code gebruikt een metabool model van *E. coli* om te onderzoeken hoe voedingsstoffen de voorspelde bacteriële groei beïnvloeden. Hiervoor wordt Flux Balance Analysis gebruikt. De code berekent het effect van extra voedingsstoffen en maakt hiervan staafdiagrammen.

### Leesbaarheid

**Score: 3/5**

De code bevat duidelijke comments en is netjes verdeeld, alleen zijn sommige functies en berekeningen voor mij te complex. Ook moest ik steeds de bestandspaden aanpassen.

### Reproduceerbaarheid

**Score: 2/5**

Ik heb geprobeerd de analyse uit te voeren in RStudio, maar dit lukte mij niet door installatieproblemen met `glpkAPI`. Hierdoor kon ik geen figuren reproduceren. De code en data zijn beschikbaar, maar de uitvoering heeft aanpassingen nodig.
