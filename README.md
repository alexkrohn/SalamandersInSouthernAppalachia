# Where is the Salamandria Miracle Mile?

People have (probably) pondered for generations where in Southern Appalachia they might find the most salamander species per square mile. Here is a (quick) attempt at an answer.

First, download the IUCN ranges of all salamanders from [here](https://www.iucnredlist.org/resources/spatial-data-download).

Next, using the R script in this repository, you can find the salamanders that occur in Southern Appalachia, then create a raster with approximately 1 mi x 1 mi resolution that counts how many species are present at the centroid of that cell. Plot that raster, add some dots for the areas with the highest diversity, and voila!

A map of the best places to visit/live to live among the greatest diversity of salamanders in Salamandria.

![Salamander Diversity Map](https://user-images.githubusercontent.com/12600348/148284867-55e47873-f358-4bff-93e7-c21d83eb026e.png)
