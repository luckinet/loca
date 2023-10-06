# Module 3.1 - Census database

The dataset of agricultural commodity and land-use census data is the central element of the loca workflow, because it serves to allocate correct areas into administrative territories and helps training suitability models.


When translating concepts in the excel files that are created here, the following excel codes can be used
`=WENN(ISTTEXT(VERWEIS(SVERWEIS(D15463;$K$2:$K$155;1;0); $K$2:$K$155; $A$2:$A$155)); VERWEIS(SVERWEIS(D15463;$K$2:$K$155;1;0); $K$2:$K$155; $A$2:$A$155); "")` for the open terms by comparing the 1 or 2 differences with the harmonised terms (paste into column K)
`=WENN(ISTZAHL(VERGLEICH(A2;$K$15463:$K$20993;0)); ""; A2)` for matching the open terms with the previous list (paste into column B)
