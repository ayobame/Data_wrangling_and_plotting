<style>
.small-code pre code {
  font-size: 0.75em;
}
</style>

ggplot2
========================================================
author: Etienne Low-Décarie
transition: rotate

About you
===




Material
===

To view presentations:
search: low-decarie wrangling github

[http://low-decarie.github.io/Data_wrangling_and_plotting/#/](http://low-decarie.github.io/Data_wrangling_and_plotting)

To view code that generated presentations:  
https://github.com/low-decarie/Data_wrangling_and_plotting  
You can look at the `.Rpres` files that generated these presentations  
You can run the code in these presentation (even all of it, using Chunks>Run All)

There is a folder called `./Data/` that contains data relavant to some of the exercises



Without R
===

![Without R](./ggplot2_images/without_r.png)

With R 
===

![With R](./ggplot2_images/with_r.png)



Beautiful and flexible! 
===

![Pretty ggplots](./ggplot2_images/pretty_examples.png)



Outline (ggplot2)
===

1. Your first ggplot plot
    + basic scatter plot 
    + Exercise 1
2. Grammar of graphics
    + More advanced plots
    + Available plot elements and when to use them
    + Exercise 2
3. Saving a plot
  + Exercise 3
  + Challenge
  
***

4. Expanding ggplot    
5. Fine tuning your plot
    + colours
    + themes
6. Maps


A few pet peeves
===

- Always work from a script
- Use carriage returns and indentation


```r
object <- function(argument1="value1",
                   argument2="value2",
                   argument3="value3")
```

- Create your own new script
  + refer to provided code only if needed
  + don't just copy paste from the presentation





Install/load ggplot2
===


```r
if(!require(ggplot2)){install.packages("ggplot2")}
require(ggplot2)
```




Your first ggplot 
===

A basic scatter plot

```r
qplot(data=iris,
      x=Sepal.Length,
      y=Sepal.Width)
```

***

![plot of chunk unnamed-chunk-6](ggplot2-figure/unnamed-chunk-6-1.png) 


Categorical x-axis  
===

```r
qplot(data=iris,
      x=Species,
      y=Sepal.Width)
```

![plot of chunk unnamed-chunk-7](ggplot2-figure/unnamed-chunk-7-1.png) 

Less basic scatter plot
===

```r
?qplot
```

Arguments
```
x
y
…
data
xlab
ylab
main
```

Less basic scatter plot 
===


```r
qplot(data=iris,
      x=Sepal.Length,
      xlab="Sepal Width (mm)",
      y=Sepal.Width,
      ylab="Sepal Length (mm)",
      main="Sepal dimensions")
```

![plot of chunk unnamed-chunk-9](ggplot2-figure/unnamed-chunk-9-1.png) 



Exercise 1
===
produce a basic plot with built in data
```
CO2
?CO2
BOD
data()
```
WARNING: THERE ARE MULTIPLE CO2/co2 datasets
(CASE SENSITIVE)

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

Grammar of graphics (gg)
===

A graphic is made of elements (layers)

- data
- aesthetics (aes)
- transformation
- geoms (geometric objects)
- axis (coordinate system)
- scales

***

![layers of a plot](./ggplot2_images/seperate_elements.png)


Aesthetics (aes) make data visible:
===

+ x,y : position along the x and y axis
+ colour: the colour of the point
+ group: what group a point belongs to 
+ shape: the figure used to plot a point
+ linetype: the type of line used (solid, dashed, etc)
+ size: the size of the point or line
+ alpha: the transparency of the point 

geometric objects(geoms)
===

+ point: scatterplot
+ line: line plot, where lines connect points by increasing x value
+ path: line plot, where lines connect points in sequence of appearance
+ boxplot: box-and-whisker plots, for categorical y data
+ bar: barplots
+ histogram: histograms (for 1-dimensional data)

Single element edit
===

Editing an element produces a new graph
e.g. just change the coordinate system


![plot of chunk unnamed-chunk-10](ggplot2-figure/unnamed-chunk-10-1.png) ![plot of chunk unnamed-chunk-10](ggplot2-figure/unnamed-chunk-10-2.png) 


How it works
===

- 1. create a simple plot object

```r
plot.object<-qplot()
or
plot.object<-ggplot()
```
- 2. add graphical layers/complexity

```r
plot.object<-plot.object+layer()
```
- 3. repeat step 2 until satisfied  
- 4. print your object to screen (or to graphical device)  

```r
print(plot.object)
```


Scatter plot as an R object
===


```r
basic.plot<-qplot(data=iris,
                  x=Sepal.Length,
                  xlab="Sepal Width (mm)",
                  y=Sepal.Width,
                  ylab="Sepal Length (mm)",
                  main="Sepal dimensions")

print(basic.plot)
```

![plot of chunk unnamed-chunk-14](ggplot2-figure/unnamed-chunk-14-1.png) 


Using ggplot function
===

more powerful, more complicated
Note: aes() and geom_point()


```r
basic.plot<- ggplot(data=iris,
               aes(x=Sepal.Length,
                  xlab="Sepal Width (mm)",
                  y=Sepal.Width,
                  ylab="Sepal Length (mm)",
                  main="Sepal dimensions"))+
  geom_point()
```
now required to use stat=""



Scatter plot with colour and shape
===


```r
basic.plot <- basic.plot+
              aes(colour=Species,
                  shape=Species)

print(basic.plot)
```

![plot of chunk unnamed-chunk-16](ggplot2-figure/unnamed-chunk-16-1.png) 


Scatter plot with linear regression
===

Add a geom (eg. linear smooth)


```r
linear.smooth.plot <- basic.plot+
			  geom_smooth(method="lm", se=F)
                         print(linear.smooth.plot)
```

![plot of chunk unnamed-chunk-17](ggplot2-figure/unnamed-chunk-17-1.png) 


Exercise 2
===

produce a colorful plot containing linear regressions with built in data

```
CO2
?CO2
msleep
?msleep
OrchardSprays
data()
```
<div class="centered">

<script src="countdown.js" type="text/javascript"></script>
<script type="application/javascript">
var myCountdown3 = new Countdown({
    							time: 300, 
									width:150, 
									height:80, 
									rangeHi:"minute"	// <- no comma on last item!
									});

</script>

</div>


Using facets and groups: the basic plot
===


```r
CO2.plot<-qplot(data=CO2,
                x=conc,
                y=uptake,
                colour=Treatment)

print(CO2.plot)
```

![plot of chunk unnamed-chunk-18](ggplot2-figure/unnamed-chunk-18-1.png) 

Facets
===


```r
plot.object<-plot.object + facet_grid(rows~columns)
```
                         
                         

```r
CO2.plot<-CO2.plot+facet_grid(.~Type)
print(CO2.plot)
```

![plot of chunk unnamed-chunk-20](ggplot2-figure/unnamed-chunk-20-1.png) 

Groups
===

Problems when adding the geom_line


```r
print(CO2.plot+geom_line())
```

![plot of chunk unnamed-chunk-21](ggplot2-figure/unnamed-chunk-21-1.png) 

Groups
===

Solution: specify groups


```r
CO2.plot<-CO2.plot+geom_line(aes(group=Plant))
print(CO2.plot)
```

![plot of chunk unnamed-chunk-22](ggplot2-figure/unnamed-chunk-22-1.png) 

Available elements
===

http://docs.ggplot2.org

<iframe src="http://docs.ggplot2.org" width="1000" height="800">
  <p>Your browser does not support iframes.</p>
</iframe>

Resources
===

cheatsheets: https://www.rstudio.com/resources/cheatsheets/

<iframe src="https://www.rstudio.com/resources/cheatsheets/" width="1000"  height="800">
  <p>Your browser does not support iframes.</p>
</iframe>


Exercise 3
===

Explore geoms and other plot elements with the data you have used
and/or your own data

```
msleep
?msleep
OrchardSprays
data()
```
<div class="centered">

<script src="countdown.js" type="text/javascript"></script>
<script type="application/javascript">
var myCountdown3 = new Countdown({
    							time: 300, 
									width:150, 
									height:80, 
									rangeHi:"minute"	// <- no comma on last item!
									});

</script>

</div>


Saving plots
===


```r
pdf("./Plots/todays_plots.pdf")
  print(basic.plot)
  print(plot.with.linear.smooth)
  print(categorical.plot)
  print(CO2.plot)
graphics.off()
```

all other base save functions available:  
`bmp()`, `jpeg()`, etc

Saving plots
===

ggsave: saves last plot and guesses format from file name


```r
ggsave("./Plots/todays_plots.jpeg", basic.plot)
```



Using the right tool for the right situation
===
base R `plot` function has methods for many different object types


```r
plot(iris)
```

![plot of chunk unnamed-chunk-25](ggplot2-figure/unnamed-chunk-25-1.png) 


Using the right tool for the right situation
===

base R `plot` function has methods for many different object types


```r
lm.SR <- lm(sr ~ pop15 + pop75 + dpi + ddpi,
            data = LifeCycleSavings)
plot(lm.SR)
```

![plot of chunk unnamed-chunk-26](ggplot2-figure/unnamed-chunk-26-1.png) ![plot of chunk unnamed-chunk-26](ggplot2-figure/unnamed-chunk-26-2.png) ![plot of chunk unnamed-chunk-26](ggplot2-figure/unnamed-chunk-26-3.png) ![plot of chunk unnamed-chunk-26](ggplot2-figure/unnamed-chunk-26-4.png) 


Challenge
===

Find an interesting data set on Dryad.org, reproduce a figure from the article using ggplot2

Example: try to reproduce figure 1 and 4 from
Low-Décarie, E., Fussmann, G. F., Bell, G., Low-Decarie, E., Fussmann, G. F., Bell, G., Low-Décarie, E., Fussmann, G. F. & Bell, G. 2014 Aquatic primary production in a high-CO2 world. Trends Ecol. Evol. 29, 1–10.    
[paper](http://www.sciencedirect.com/science/article/pii/S0169534714000433)  
[data](http://datadryad.org/handle/10255/dryad.60481)  
full scripts also available on github (old ugly code!)


Extending ggplot
===

ggplot can be extended for plotting specific classes of objects

`autoplot`
and
`fortify`


Extending ggplot
===

`ggfortify` provides `autoplot`and  
`fortify` for common models


```r
require(ggfortify)
autoplot(lm.SR)
```

***

![plot of chunk unnamed-chunk-28](ggplot2-figure/unnamed-chunk-28-1.png) 

===


```r
help(package=ggfortify)
```

Vegan users
===


```r
if(!require(devtools)) {install.packages("devtools")}
require(devtools)
if(!require(ggvegan)) {install_github("gavinsimpson/ggvegan")}
require(ggvegan)
data(dune)
data(dune.env)
```

Vegan users
===


```r
sol <- cca(dune ~ A1 + Management,
           data = dune.env)
autoplot(sol)
```

![plot of chunk unnamed-chunk-31](ggplot2-figure/unnamed-chunk-31-1.png) 

Vegan users
===


```r
autoplot(sol) + theme_bw()
```

![plot of chunk unnamed-chunk-32](ggplot2-figure/unnamed-chunk-32-1.png) 



Using the right tool for the right situation
===

base R `plot` function has methods for many different object types


```r
normal.plot <- plot(sol)
```

![plot of chunk unnamed-chunk-33](ggplot2-figure/unnamed-chunk-33-1.png) 


Fine tunning: Scales
===
class: small-code


```r
CO2.plot +
  scale_y_continuous(name = "CO2 uptake rate",
                     breaks = seq(5,50, by= 10),
                     labels = seq(5,50, by= 10), 
                     trans="log10")
```

![plot of chunk unnamed-chunk-34](ggplot2-figure/unnamed-chunk-34-1.png) 

Fine tunning: Scales
===


```r
CO2.plot+
  scale_colour_brewer()
```

![plot of chunk unnamed-chunk-35](ggplot2-figure/unnamed-chunk-35-1.png) 

Fine tunning: Scales
===


```r
CO2.plot+
  scale_colour_manual(values=c("nonchilled"="red",
                               "chilled"="blue"))
```

![plot of chunk unnamed-chunk-36](ggplot2-figure/unnamed-chunk-36-1.png) 


Fine tunning: Scales
===
Bonus!!! Wes Anderson colour palette

![darjeelinglimited](./ggplot2_images/darjeelinglimited.jpg)

Fine tunning: Scales
===
Bonus!!! Wes Anderson colour palette


```r
if(!require(devtools)) {install.packages("devtools")}
require(devtools)
if(!require(wesanderson)){
devtools::install_github("karthik/wesanderson")}
require(wesanderson)
```

Fine tunning: Scales
===
Bonus!!! Wes Anderson colour palette


```r
require(wesanderson)
basic.plot + 
  scale_color_manual(values = wesanderson::wes_palette("Darjeeling",3)) 
```

![plot of chunk unnamed-chunk-38](ggplot2-figure/unnamed-chunk-38-1.png) 

Fine tuning: Multiple plots
===



```r
if(!require(gridExtra)) {install.packages("gridExtra")}
require(gridExtra)

grid.arrange(basic.plot, CO2.plot)
```

![plot of chunk unnamed-chunk-39](ggplot2-figure/unnamed-chunk-39-1.png) 

Fine tuning: Multiple plots
===
class: small-code

Sub-plots can be aligned and matched in size


```r
basic.plot.table <- ggplot_gtable(ggplot_build(basic.plot))
CO2.plot.table <- ggplot_gtable(ggplot_build(CO2.plot))
maxWidth = grid::unit.pmax(basic.plot.table$widths[2:3],
                           CO2.plot.table$widths[2:3])
basic.plot.table$widths[2:3] <- as.list(maxWidth)
CO2.plot.table$widths[2:3] <- as.list(maxWidth)
```

Fine tuning: Multiple plots
===
Sub-plots can be aligned and matched in size


```r
grid.arrange(basic.plot.table, 
             CO2.plot.table,
             ncol=1)
```

![plot of chunk unnamed-chunk-41](ggplot2-figure/unnamed-chunk-41-1.png) 

Fine tuning: Themes
===

`theme_set(theme())`  
or  
`plot+theme()`


```r
bw <- basic.plot+theme_bw()
grey <- basic.plot+theme_bw()

grid.arrange(basic.plot, bw, grey, nrow=1)
```

![plot of chunk unnamed-chunk-42](ggplot2-figure/unnamed-chunk-42-1.png) 


Fine tuning: Themes
===
class: small-code


```r
mytheme <- theme_grey() +
 theme(plot.title = element_text(colour = "red"))
mytheme_plot <- basic.plot + mytheme

grid.arrange(basic.plot, mytheme_plot, nrow=1)
```

![plot of chunk unnamed-chunk-43](ggplot2-figure/unnamed-chunk-43-1.png) 


Challenge
===

Using figure from previous challenge (or other dryad.org paper/data), edit figure to match a journal's style requirements

Example: try to reproduce Figure 3 in:
Lucek K, Sivasundar A, Roy D, Seehausen O (2013) Repeated and predictable patterns of ecotypic differentiation during a biological invasion: lake-stream divergence in parapatric Swiss stickleback. Journal of Evolutionary Biology 26(12): 2691–2709. 

[paper](http://dx.doi.org/10.1111/jeb.12267)  
[data](http://dx.doi.org/10.5061/dryad.0nh60)  
