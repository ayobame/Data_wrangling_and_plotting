<style>
.reveal section code {
  font-size: 1em;
}
</style>


tidyr
========================================================
author: Etienne Low-Décarie
date: September 24, 2015

Long vs wide data
===

Wide

![plot of chunk unnamed-chunk-1](tidyr-figure/unnamed-chunk-1-1.png) 

Long

![plot of chunk unnamed-chunk-2](tidyr-figure/unnamed-chunk-2-1.png) 


Tidy vs untidy data
===

Tidy data

1. Each variable forms a column.
2. Each observation forms a row.
3. Each type of observational unit forms a table.

Messy data
- Anything else

Wickham, H. (2014). Tidy Data. J. Stat. Softw., 59, 1–2.


History
===

- reshape and reshape2  
  - melt and cast
  - aggregate: summary calculations
- tidyr
  - only data frames
  - simple unique use verbs
  - no summarising/aggregation


Going from wide to long
===
class: small-code

`gather`


```r
long_data<-gather(wide_data,
                  key,
                  value,
                  selected_columns)
```

`melt` in `reshape`(`2`)

Ways to select columns
===

- Use bare variable names.

```r
long_iris<-gather(iris,"Measurement",
                  "Value",
                  Sepal.Length,
                  Sepal.Width,
                  Petal.Length,
                  Petal.Width)

grid.table(head(long_iris))
```

![plot of chunk unnamed-chunk-4](tidyr-figure/unnamed-chunk-4-1.png) 

Ways to select columns
===

- Select all variables between `x` and `z` with `x:z`

```r
long_iris<-gather(iris,"Measurement",
                  "Value",
                  Sepal.Length:Petal.Width)
```


Ways to select columns
===

- Exclude y with `-y`.

```r
long_iris<-gather(iris,"Measurement",
                  "Value",
                  -Species)
```


Exercise 1
===

- basic challenge
  - make the `data(BCI)` long (`require(vegan)`)
  - make the data in `data(simesants)` long (`require(simesants)`)
  
<div class="centered">

<script src="countdown.js" type="text/javascript"></script>
<script type="application/javascript">
var myCountdown2 = new Countdown({
    							time: 300, 
									width:150, 
									height:80, 
									rangeHi:"minute"	// <- no comma on last item!
									});

</script>

</div>

- extra challenge:  
use `gather` to produce a data.frame from a jpeg  
that can be plotted using ggplot
  - download
  - plot the red channel of the UQAM logo
  
Exercise 1
===


```r
image_data <- readPNG("./Data/logo_uqam.png")
red <- as.data.frame(image_data[,,1])
red$y <- as.numeric(rownames(red))
red_long <- gather(red,"x","value", -y)
red_long$x <- as.numeric(gsub("V","", red_long$x))
qplot(data=red_long,
      x=x,
      y=-y,
      fill=value,
      geom="raster")
```



Going from long to wide
===

`spread`


```r
wide_data <- spread(long_data,
                    key,
                    value)
```

(`d`/`a`)cast in `reshape`(`2`)

Going from long to wide
===


```r
wide_iris <- spread(long_iris,
                    Measurement,
                    Value)
```

Going from long to wide
===
Each case must have a label!


```r
iris$Specimen <- 1:nrow(iris)

long_iris<-gather(iris,"Measurement",
                  "Value",
                  Sepal.Length:Petal.Width)

wide_iris <- spread(long_iris,
                    Measurement,
                    Value)
```


Exercise 2
===

- create a data.frame of `data(barley)` from `require(lattice)`  
in which each `variety` is in a seperate column

<div class="centered">

<script src="countdown.js" type="text/javascript"></script>
<script type="application/javascript">
var myCountdown2 = new Countdown({
    							time: 300, 
									width:150, 
									height:80, 
									rangeHi:"minute"	// <- no comma on last item!
									});

</script>

</div>


Exercise 2
===





















```
Error in match(x, table, nomatch = 0L) : object 'barley' not found
```
