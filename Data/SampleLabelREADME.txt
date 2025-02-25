SampleLabelREADME.txt

###############
### Purpose ###
###############
This file explains how to interpret the "SampleLabel" column in data files associated with the data releases titled:
	* Lake depth profile, water quality, sediment, periphyton, tadpole (Pseudacris regilla), and landscape data from six lakes and two stream sites of the Tokopah Basin in Sequoia National Park, California, 2021-2022
	* Water quality, and periphyton growth, copper concentration, and community structure data associated with a nutrient diffusing substrate experiment conducted in Pear Lake, Sequoia National Park, California in 2022.
  
These values were assigned to water, sediment, and tissue samples.  Interpreting these labels can help a user of these data better comprehend the sampling design and may make code clean-up and carpentry easier.


##############################
### Sample Labeling Scheme ###
##############################
The labeling scheme includes codes for lake/location name, lake section, trip number (i.e., month), year, sample type, and whether a sample is single sample, a duplicate, a blank, or a replicate.  All labels have the same number of characters and are split into six code sections separated by an underscore or period.

The labels are written as follows:
XX_X_#.##_XXX_XX

where, in order:
|------|------------------------------------------------------------------------|
| Code | Meaning                                                                |
|------|------------------------------------------------------------------------|
| XX   | indicates the Lake/Location Name                                       |
| X    | indicates the Lake Section                                             |
| #    | indicates the Trip Number (i.e. month)                                 |
| ##   | indicates the Year                                                     |
| XXX  | indicates the Sample Type                                              |
| XX   | indicates the if a sample is a single, duplicate, blank, or replicate  |
|------|------------------------------------------------------------------------|


Each code is defined according to the respective table.
|--------------------|-----------------------------------------------------------------|
| Lake/Location Name | Description                                                     |
|--------------------|-----------------------------------------------------------------|
| EM                 | Emerald Lake                                                    |
| FR                 | Frog Lake                                                       |
| HE                 | Heather Lake                                                    |
| LY                 | Lyness Lake                                                     |
| PE                 | Pear Lake                                                       |
| TO                 | Topaz Lake                                                      |
| US                 | USGS Station (downstream location of Marble Fork Kaweah River)  |          
| TL                 | Tablelands (upstream location of Marble Fork Kaweah River)      |
|--------------------|-----------------------------------------------------------------|


|--------------|----------------------------------------------------------|
| Lake Section | Description                                              |
|--------------|----------------------------------------------------------|
| A            | Section A                                                |
| B            | Section B                                                |
| C            | Section C                                                |
| O            | Other (i.e., sample was not targeted in a lake section)  |
|--------------|----------------------------------------------------------|


|-------------|---------------------|
| Trip Number | Description         |
|-------------|---------------------|
| 1           | Trip 1 (June)       |
| 2           | Trip 2 (July)       |
| 3           | Trip 3 (August)     |
| 4           | Trip 4 (September)  |
| 5           | Trip 5 (October)    |
|-------------|---------------------|


|------|--------------|
| Year | Description  |
|------|--------------|
| 21   | 2021         |
| 22   | 2022         |
|------|--------------|



|-------------|-------------------------------------------------------------------------|
| Sample Type | Description                                                             |
|-------------|-------------------------------------------------------------------------|
| CAT         | water sample collected for cations                                      |
| DOC         | water sample collected for dissolved organic carbon                     |
| ANI         | water sample collected for anions                                       |
| WCU         | water sample collected for copper                                       |
| DNP         | water sample collected for dissolved nutrients (nitrogen & phosphorus)  |
| TPH         | water sample collected for total phosphorus                             |
| SCU         | sediment sample collected for copper                                    |
| ADM         | periphyton sample collected for ash-free dry mass                       |
| PCH         | periphyton sample collected for chlorophyll a                           |
| PCU         | periphyton sample collected for copper                                  |
|-------------|-------------------------------------------------------------------------|


|------------------|-------------------------------------------------------------------------|
| Sample Qualifier | Description                                                             |
|------------------|-------------------------------------------------------------------------|
| ZZ               | single sample (ZZ is effectively a placeholder)                         |
| DU               | duplicate sample                                                        |
| BL               | blank sample                                                            |
| E1, E2, E3       | "extra sample 1", "extra sample 2", etc. (only used for NDS study)      |
| R1, R2, R3       | replicate sample 1, 2, 3 (used for periphyton sample replicates)        |
|------------------|-------------------------------------------------------------------------|


################
### Examples ###
################

1)
A subset of sediment samples may be labeled 
* LY_A_2.21_SCU_ZZ
* LY_A_2.21_SCU_DU
* LY_B_2.21_SCU_ZZ
* LY_C_2.21_SCU_ZZ

These represent sediment samples collected for copper ('SCU') from Lyness Lake ('LY') in July of 2021 ('2.21').  A total of four samples were collected, with one each from lake sections A, B, and C, and a duplicate sample from section A.

2)
A subset of periphyton samples labeled as:
* PE_B_4.22_ADM_R2
This is a periphyton ash-free dry mass sample ('ADM'), replicate 2 ('R2'), collected from section B ('B') at Pear Lake ('PE') in September 2022 ('4.22').

* HE_C_5.21_PCU_R3
This is a periphyton copper sample ('PCU'), replicate 3 ('R3'), collected from section C ('C') at Heather Lake ('HE') in October 2021 ('5.21').

* TO_A_3.22_PCH_R1
This is a periphyton chlorophyll a sample ('PCH'), replicate 1 ('R1'), collected from section A ('A') at Topaz Lake ('TO') in August 2022 ('3.22').
