# Module 5 - Initial land use modelling
 
***module: 04_build_initial_landuse***

## Definitions

## Input data 

This algorithm has the objective to allocate landuse classes and agricultural commodities into a landcover map at the initial time-step. It requires as input

1) the **ESA CCI landcover map** and the specific **land use limits**:
    
    The association between ESA landcover (ESALC) classes and FAO landuse (FAOLU) classes is not unambiguous with respect to the amount of a LC pixel that can be covered by a certain LU class. However, some conservative assumptions in the form of smallest and largest cover with a certain ranges are feasible. These associations have the purpose of establishing consistency between FAOLU and ESALC, i.e., that the amount of LU demand allocated into a LC pixel (supply) does not conflict with the definition of the LC class. For example, Cropland/Natural mosaic LC (ESA ID 30) has a supply of cropland of 50 or more percent, and a supply of forestland of 50 or less percent of the respective pixel area.

2) **suitability maps** of all landuse classes:

    The suitability maps are a second source of information (independent of landcover) that give the probability that a pixel belongs to one of several (land-use) classes. It allows to derive two signals, 
      a) the **rank of each land-use class**, which is used to determine the order of land-use into which to allocate demand.
      b) the spatial distribution of each land-use class and thus **relative weight** of different pixels in comparison to the other pixels, which is used to determine the explicit relative amount that can be allocated into each pixel.</br></br>

3) a map that provides the **restricted sub-pixel proportion**:

    This map has impervious areas and water surfaces (both of which restrict all other landuse types) subtracted from the area that is covered by a pixel and constitutes thus another source of \"landuse limit\" that needs to be considered.
    
4) **census statistics of landuse** (of both, FAO landuse classes and our harmonised commodities):

    The census statistics constitute the actual demand that needs to be distributed into the map during allocation. There are data at the national and at the subnational (local) level, both from different sources and thus not perfectly consistent with each other. The algorithm determines supply by calculating pixel specific suitability weighted supply and up or downweighs this with local-to-national deviation to be consistent not only between landcover and landuse, but also  with local census data.

## The algorithm

The following gives a technical description of this algorithm. It first derives intermediate data objects: 

a) maps of *LU limits* ($LU_{min}$ and $LU_{max}$) as implied by the respective definition of the utilized landcover product (ESALC in our case). 
b) maps of *suitability rank* of all the LU classes in question (for instance between forest, grazing and cropland, or between the commodities available in the region)
c) a table of *allocation groups*, i.e., those groups of landcover classes that have the same range of LU limits.
d) maps of *suitability ranges* ($S_{min}$ and $S_{max}$), i.e., the minimum and maximum suitability values per suitability rank and allocation group.

Next, the algorithm carries out a pre-allocation step that serves to tally up (I) minimum supply, (II) maximum supply and (III) suitability weighted supply ($SWS$). Minimum and maximum supply are calculated by simply multiplying the landuse limits with pixel area and suitability weighted supply is calculated by first scaling suitability between the lanuse limits (via [min-max normalisation between arbitrary values](https://learn.64bitdragon.com/articles/computer-science/data-processing/min-max-normalization)) and then multiplying with pixel area.

\begin{equation} 
x' = \frac{(b - a) \cdot (x - x_{min})}{x_{max} - x_{min}} + a
\end{equation}

with $x = suitability$ and accordingly $x_{min/max} = S_{min/max}$, $a = LU_{min}$ and $b = LU_{max}$


Local stats most likely indicate than the actual demand is either higher or lower than he sum of $SWS$ and this can be corrected by adapting the factors between which suitability is scaled ($LU_{min}$ and $LU_{max}$).
Based on the deviation between demand (the local census stats that ought to be allocated) and supply (what the pixels currently allow), the amount allowed per each pixel is either up or downscaled. In case there is more demand than supply, the minimum is increased and vice versa, the maximum is decreased. Using these new values in the rescaling equation will lead to allocating an amount that will sum up to demand.

- with the corrected LU limits, demand can be allocated into landcover pixels
- likewise, the then created landuse maps are an envelope for agricultural commodities, which are analgously related to encompassing classes
- and livestock as well, is allocated into the suitable classes of landuse and commodities

| envelope | included | relationship |
|:- | :- | :- |
| landcover | landuse | associated to subpixel value |
| landuse | commodities | associated without value (determined merely by suitability) |
| commodities & landuse | livestock | associated via relative value |



## Deriving corrected landuse limits



I have a couple values that indicate suitability of pixels and I have landuse ranges (luMin, luMax) that limit how much can be allocated into a pixel (supply). I have to allocate a certain amount of demand into the pixels, hence, I will have to determine the landuse limits so that supply matches demand.

suitability weighted supply (sws) gives me the relative weight of each pixel, by scaling suitability between the landuse limits (min-max-normalisation)
```
sws = (suit - min(suit))/(max(suit) - min(suit)) * (luMax - luMin) + luMin
```

the overall supply is sws multiplied with the area of each pixel
```
supply = sum(sws * area)
supply = sum(((suit - min(suit))/(max(suit) - min(suit)) * (luMax - luMin) + luMin) * area)
```

there may be two cases, either demand is lower or higher than supply. When demand is lower than supply, dev > 1. In that case I decrease the upper limit and keep the lower limit, so that all sws-values become smaller after re-scaling and thus supply is smaller. For dev < 1, I need to increase the lower limit and keep the upper limit to have all sws-values increase and thus supply to increase.

I derive new min and max values to scale between, by equating demand and supply and replacing luMin with newMin and luMax with newMax

```
# given
suit = abs(rnorm(n = 50))
luMin = 0.1
luMax = 1
demand = 1500000
area = rep(90000, 50)

demand = supply
demand = sum(((suit - min(suit))/(max(suit) - min(suit)) * (newMax - newMin) + newMin) * area)
   # with suitVals = (suit - min(suit))/(max(suit) - min(suit))
demand = sum((suitVals * (newMax - newMin) + newMin) * area)
demand = sum(area * (newMax*suitVals - newMin*suitVals + newMin))
demand = sum(newMax*area*suitVals - newMin*area*suitVals + newMin*area)
demand = sum(newMax*area*suitVals) - sum(newMin*area*suitVals) + sum(newMin*area)

# ... newMin
     sum(newMin*area) - sum(newMin*area*suitVals)   =  demand - sum(newMax*area*suitVals)
newMin *  sum(area)   - newMin * sum(suitVals*area) =  demand - sum(newMax*area*suitVals)
newMin * (sum(area)   - sum(suitVals*area))         =  demand - sum(newMax*area*suitVals)
newMin                                       = (demand - sum(newMax*area*suitVals)) / (sum(area) - sum(suitVals*area))

# ... newMax
sum(newMax*area*suitVals)   =  demand + sum(newMin*area*suitVals) - sum(newMin*area)
newMax * sum(suitVals*area) =  demand + sum(newMin*area*suitVals) - sum(newMin*area)
newMax                      = (demand + sum(newMin*area*suitVals) - sum(newMin*area)) / sum(suitVals*area)
```

then I re-scale with those new values

```
dev = supply / demand
suitVals <- (suit - min(suit))/(max(suit) - min(suit))
if(dev >= 1){
  newMin <- luMin
  newMax <- (demand + sum(newMin * area * suitVals) - sum(newMin * area)) / sum(suitVals * area)
} else {
  newMax <- luMax
  newMin <- (demand - sum(newMax * area * suitVals)) / (sum(area) - sum(suitVals * area))
}
cs <- (suit - min(suit))/(max(suit) - min(suit)) * (newMax - newMin) + newMin
correctedSupply <- round(sum(cs * area))
correctedSupply == demand                               # that is equal to demand
```

## Output



# Misc info


## old text (archived for reference)
## 
Derived from the definitions of classes in of ESA landcover we can distinguish the two cases where (A) two classes form a mosaic and (B) one landcover is dominant:

- For case A, we know that one of the two classes is dominating, i.e. that class is between 50% and (100 - x)% and the other class is between x% and 50%, with x% as the smallest possible sub-pixel proportion (for example, that is detectable by the sensors and algorithm involved in building the ESA landcover product). There are mosaic classes for cropland vs natural vegetation and tress+shrubs vs herbaceous vegetation. As the cropland vs natural mosaics are the only ones that give a clear indication of how much or little of a particular landuse category there must be (as trees, shrubs and herbs could be associated to several landuses), we start allocating the required amounts into those, so that these mosaic pixels are consistent.

- For case B we do NOT know how many classes were available when classifying the ESA landcover product (despite that they are called "pure" in the user guide), so we do not know the proportion that was covered by the dominating class. It could be more than or equal to 50% in case there were two classes, but it could also be more than or equal to 20%, in case there were five classes. WE DO, however, know that the class in question must be present and must be more abundant than any other class. Moreover, ESA landcover contains only the cropland and the urban/bare classes as "pure" classes. Any other ESA landcover class could be associated to several landuses (for instance "trees" could be used as forest, grazing or wilderness and "shrubs" could be used as grazing, permanent crops or also wilderness, etc...). The second allocation step is thus to allocate a certain minimum amount of the respective landuse type into those pixels, so that also all the non-mosaic pixels with a clear minimum signal contain that amount of landuses that is required by their landcover.

Conceptually, when implementing code for it, case A and B follow the same logic, they take a minimum value for a particular class and make sure that all pixels of that class contain that minimum.
