In the `candisc` R package, I have a function, `plot_discrim()` to plot the results of a linear discriminant analysis
for two variables. The code is at https://raw.githubusercontent.com/friendly/candisc/refs/heads/master/R/plot_discrim.R.
I'd like you to help make this more general. I'll ask for one thing at a time.

It has an argument `ellipse` to control the display of data ellipses for the groups, but the attributes 
(level = 0.68, linewidth = 1.2) are hard-coded in the call to `stat_ellipse()` and there is no
`geom` argument to control whether the ellipse is filled (`geom = "polygon"`) or unfilled
(`geom = "path"`). I think the simplest thing for the user would be to add an argument,
`ellipse.args = list(...)` that could handle `level`, `linewidth`, etc. and then feed these
values into the call to `stat_ellipse()`. The `list(...)`  should allow any arguments
valid for `stat_ellipse()`. Document these changes in the roxygen comments like
`@param ellipse.args`.

The function currently plots in the space of the observed variables. I'd like to also
allow it to plot the observations and predictions in discrinimant space.
This can be done by allowing the `vars` argument to take the special form
`LD2 ~ LD1` or `LD1 ~ LD2`. Then for generating the grid of predicted classes
the function should calculate a new `lda()` of the form
`mod.lda <- lda(class ~ LD1 + LD2, data=) where `data` is the set of 
data values for the variables obtained by `data = insight::get_data(model)`.

I would like to be able to add direct labels for the classes using either
`geom_text()` or `geom_label()`. These should be positioned near the means
of the classes. As part of this the function should calculate the class means
for the variables to be plotted. Here is the code I tried, but it gave errors
```
 class_means <- data |>
   group_by(!!!class) |>
   select(!!!vars) |>
   summarise(across(vars), mean)
```
Then, implement a `labels = TRUE/FALSE` argument, with default `FALSE`.
Along with this, implement a `labels.args = list(...)` which can take
`geom = "text"` or `geom = `label`, along with other arguments to these
like `nudge_x`, `nudge_y`.

Next, rename the argument `modes.means` to `other.levels` and better explain in the documentation
that it controls how the non-focal variables are represented in the data frame used to generate
the predicted classes over the grid.
