<head> <b><p>#r experiments</p></b></head>


<b> <p>exp #4</p>
some 3d plots using plotly in r and games sales data.
a line plot of american sales vs global sales with a timeline
<p><img src="https://github.com/ipsitrath/r_exp/blob/master/Exp%204/plot/line3d.html"></p>

<p>now lets try a scatter of sales figures categorized by game platforms</p>

<p><img src="https://github.com/ipsitrath/r_exp/blob/master/Exp%204/plot/scatter3d.html.png"></p>


<b> <p>exp #3</p>

google map intensity plots using global terrorism index dataset; showing statewise terrorist incidents in India.
<p><img src="https://github.com/ipsitrath/r_exp/blob/master/Exp%203/plots/map1.png"></p>

<p> Time line of terrorist incidents in India</p>
<p><img src ="https://github.com/ipsitrath/r_exp/blob/master/Exp%203/plots/line2.png"></p>

<p>Major terrorist attack targets in India</p>

<p><img src="https://github.com/ipsitrath/r_exp/blob/master/Exp%203/plots/bubble2.png"></p>


<p>exp #2</p>
Some Interesting plots using IMDB 5000 movie dataset and plotly in r.

Lets plot Gross earnings of movies with their budgets.
<p><img src="https://github.com/ipsitrath/r_exp/blob/master/Exp%202/plots/budgetvsgross1.png"></p>

Lets investigate the relationship further. 
We can see; higher the IMDB ratings; the relation between gross returns and budget is more linear.
<p><img src="https://github.com/ipsitrath/r_exp/blob/master/Exp%202/plots/grossvsbudget2.png"></p>

A simple Pie Chart to summarize things.</b>
<p><img src="https://github.com/ipsitrath/r_exp/blob/master/Exp%202/plots/pie1.png"></p>


<p> r exp #2</p>
R has excellent visulization packages like ggplot2, lattice, plotly etc.
<p>I used the primary Indian industrial data; "Annual Survey of Industries" to summarize different aspects of Indian industries using ggplot2 visulization.</p>

First lets see the no. of workers per firm in different states. A bar plot would have sufficed for the comparision but the jitter plot shows the concentration of firms according to their workforce. If you consider 'no. of workers' as a proxy for larger firms; you can see the concentration of larger and smaller firms of a state vis-a-vis with other states


<p><img src="https://github.com/ipsitrath/r_exp/blob/master/Exp%201/plots/workers.png"></p>

The same plot with Rural and Urban grouping
<p><img src="https://github.com/ipsitrath/r_exp/blob/master/Exp%201/plots/workersru.png"></p>

Now lets see bring in ouput of the firms into the picture. The overall trend we can see here is that, firms with larger workforce produce greater outputs
<p><img src="https://github.com/ipsitrath/r_exp/blob/master/Exp%201/plots/ovsw.png"></p>

Now let's create a scatterplot of 'Gross Value Added' of the firms versus their no. workers with regression lines.
Here I used the "car" package's 'scatterplot' to create the plots.
<p><img src="https://github.com/ipsitrath/r_exp/blob/master/Exp%201/plots/gva%20vs%20workers.png"></p>

<p>Another scattar of Wage vs Workers</p>
<p><img src="https://github.com/ipsitrath/r_exp/blob/master/Exp%201/plots/wage%20vs%20workers.png"></p>

<p>Based on all the plots we have done we can see there is certain correlation. Let's take a look at the pairwise correlation to ascertain the relationships in more detail.</p>

<p><img src="https://github.com/ipsitrath/r_exp/blob/master/Exp%201/plots/corr.png"></p>

<p>Average labor productivity(value_added/mandays) of the states, using ASI 2001-13 data.</p>
<p><img src="https://github.com/ipsitrath/r_exp/blob/master/Exp%201/plots/lp1.png"></p>


