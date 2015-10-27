<style>
.small-code pre code {
  font-size: 0.75em;
}
</style>

ggplot2
========================================================
author: Etienne Low-Décarie
date: October 27 2015
transition: rotate

Waiting around?
===
class: small-code

Let R impress you:

```r
demo(package = .packages(all.available = TRUE))
```
- you will get a text file with all available demos
- choose one of interest 
- if needed load its package

***

- type it in the demo brackets
- example

```r
library(googleVis)
demo(smooth)
```
- notice it shows you the code that creates the demo!
- look at packages on [crantastic.org](http://crantastic.org)


Tell me about you
===

- Have you created a plot?
- With what data?
- What kind of plot?
- Have plotted with R?
- used ggplot?
- How many variables do you usually need to put into a plot?
- Do you need to produce maps?
- Have you used stackoverflow?
- Are you in buddy pairs?
- Who uses Rstudio as their IDE?

Outline
===

- 09:00-11:00 ggplot2
- 11:00-13:30 lunch (potential to work on challenge)
- 13:30-14:00 tidyr
- 14:00-15:30 dplyr
- 15:30-16:30 Maps using ggplot/ggmap
- 16:30-17:30 Coding dojo

How we will work
===

![How we will work](./ggplot2_images/how we work.png)



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




A few preferences
===

- Use RStudio
  - Use RStudio projects (or R package etc.)
- Craete organized folder structure
  - Data
  - Plots
  - Scripts
  - Output
  - etc

Material
===

To view presentations:  
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





Install/load ggplot2
===


```r
if(!require(ggplot2)){install.packages("ggplot2")}
require(ggplot2)
```

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

(PM?)  

4. Expanding ggplot    
5. Fine tuning your plot
    + colours
    + themes



Your first ggplot 
===

A basic scatter plot

```r
qplot(data=iris,
      x=Sepal.Length,
      y=Sepal.Width)
```

***

![plot of chunk unnamed-chunk-8](ggplot2-figure/unnamed-chunk-8-1.png) 


Categorical x-axis  
===

```r
qplot(data=iris,
      x=Species,
      y=Sepal.Width)
```

![plot of chunk unnamed-chunk-9](ggplot2-figure/unnamed-chunk-9-1.png) 

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

![plot of chunk unnamed-chunk-11](ggplot2-figure/unnamed-chunk-11-1.png) 

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


![plot of chunk unnamed-chunk-12](ggplot2-figure/unnamed-chunk-12-1.png) ![plot of chunk unnamed-chunk-12](ggplot2-figure/unnamed-chunk-12-2.png) 


How it works
===

1. create a simple plot object

```r
plot.object<-qplot()
```
2. add graphical layers/complexity

```r
plot.object<-plot.object+layer()
```
3. repeat step 2 until satisfied  
4. print your object to screen (or to graphical device)  

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

![plot of chunk unnamed-chunk-16](ggplot2-figure/unnamed-chunk-16-1.png) 

Scatter plot with colour and shape
===


```r
basic.plot <- basic.plot+
              aes(colour=Species,
                  shape=Species)

			print(basic.plot)
```

![plot of chunk unnamed-chunk-17](ggplot2-figure/unnamed-chunk-17-1.png) 


Scatter plot with linear regression
===

Add a geom (eg. linear smooth)


```r
linear.smooth.plot <- basic.plot+
			  geom_smooth(method="lm", se=F)
                         print(linear.smooth.plot)
```

![plot of chunk unnamed-chunk-18](ggplot2-figure/unnamed-chunk-18-1.png) 


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

![plot of chunk unnamed-chunk-19](ggplot2-figure/unnamed-chunk-19-1.png) 

Facets
===


```r
plot.object<-plot.object + facet_grid(rows~columns)
```
                         
                         

```r
CO2.plot<-CO2.plot+facet_grid(.~Type)
print(CO2.plot)
```

![plot of chunk unnamed-chunk-21](ggplot2-figure/unnamed-chunk-21-1.png) 

Groups
===

Problems when adding the geom_line


```r
print(CO2.plot+geom_line())
```

![plot of chunk unnamed-chunk-22](ggplot2-figure/unnamed-chunk-22-1.png) 

Groups
===

Solution: specify groups


```r
CO2.plot<-CO2.plot+geom_line(aes(group=Plant))
print(CO2.plot)
```

![plot of chunk unnamed-chunk-23](ggplot2-figure/unnamed-chunk-23-1.png) 

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

![plot of chunk unnamed-chunk-26](ggplot2-figure/unnamed-chunk-26-1.png) 


Using the right tool for the right situation
===

base R `plot` function has methods for many different object types


```r
lm.SR <- lm(sr ~ pop15 + pop75 + dpi + ddpi, data = LifeCycleSavings)
plot(lm.SR)
```

![plot of chunk unnamed-chunk-27](ggplot2-figure/unnamed-chunk-27-1.png) ![plot of chunk unnamed-chunk-27](ggplot2-figure/unnamed-chunk-27-2.png) ![plot of chunk unnamed-chunk-27](ggplot2-figure/unnamed-chunk-27-3.png) ![plot of chunk unnamed-chunk-27](ggplot2-figure/unnamed-chunk-27-4.png) 


Challenge
===

Find an interesting data set on Dryad.org, reproduce a figure from the article using ggplot2

Example: try to reproduce figure Figure 1A from  
Dutilleul, M. et al., 2014. Rapid evolutionary responses of life history traits to different experimentally-induced pollutions in Caenorhabditis elegans. BMC evolutionary biology, 14(1), p.252.  
[paper](http://www.biomedcentral.com/content/pdf/s12862-014-0252-6.pdf)  
[data](https://datadryad.org/bitstream/handle/10255/dryad.71040/multiG2.csv?sequence=1)  
(author from UQAM)


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

![plot of chunk unnamed-chunk-29](ggplot2-figure/unnamed-chunk-29-1.png) 

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

![plot of chunk unnamed-chunk-32](ggplot2-figure/unnamed-chunk-32-1.png) 

Vegan users
===


```r
autoplot(sol) + theme_bw()
```

![plot of chunk unnamed-chunk-33](ggplot2-figure/unnamed-chunk-33-1.png) 



Using the right tool for the right situation
===

base R `plot` function has methods for many different object types


```r
normal.plot <- plot(sol)
```

![plot of chunk unnamed-chunk-34](ggplot2-figure/unnamed-chunk-34-1.png) 


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

![plot of chunk unnamed-chunk-35](ggplot2-figure/unnamed-chunk-35-1.png) 

Fine tunning: Scales
===


```r
CO2.plot+
  scale_colour_brewer()
```

![plot of chunk unnamed-chunk-36](ggplot2-figure/unnamed-chunk-36-1.png) 

Fine tunning: Scales
===


```r
CO2.plot+
  scale_colour_manual(values=c("nonchilled"="red",
                               "chilled"="blue"))
```

![plot of chunk unnamed-chunk-37](ggplot2-figure/unnamed-chunk-37-1.png) 


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

![plot of chunk unnamed-chunk-39](ggplot2-figure/unnamed-chunk-39-1.png) 

Fine tuning: Multiple plots
===



```r
if(!require(gridExtra)) {install.packages("gridExtra")}
require(gridExtra)

grid.arrange(basic.plot, CO2.plot)
```

![plot of chunk unnamed-chunk-40](ggplot2-figure/unnamed-chunk-40-1.png) 

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

![plot of chunk unnamed-chunk-42](ggplot2-figure/unnamed-chunk-42-1.png) 

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

![plot of chunk unnamed-chunk-43](ggplot2-figure/unnamed-chunk-43-1.png) 


Fine tuning: Themes
===
class: small-code


```r
mytheme <- theme_grey() +
 theme(plot.title = element_text(colour = "red"))
mytheme_plot <- basic.plot + mytheme

grid.arrange(basic.plot, mytheme_plot, nrow=1)
```

![plot of chunk unnamed-chunk-44](ggplot2-figure/unnamed-chunk-44-1.png) 


Challenge
===

Find an interesting data set on Dryad.org, reproduce a figure from the article using ggplot2

Example: try to reproduce figure Figure 1A from  
Dutilleul, M. et al., 2014. Rapid evolutionary responses of life history traits to different experimentally-induced pollutions in Caenorhabditis elegans. BMC evolutionary biology, 14(1), p.252.  
[paper](http://www.biomedcentral.com/content/pdf/s12862-014-0252-6.pdf)  
[data](https://datadryad.org/bitstream/handle/10255/dryad.71040/multiG2.csv?sequence=1)  
(author from UQAM)
