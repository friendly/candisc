# candisc: tasks

- [ ] **Overlapping labels for group means in `heplot.candisc()`.** Found 2026-11-21 in the
  blog draft "On Extending `lm()` Methods to `"mlm"`" (friendly.github.io,
  `blog/drafts/MLM-extensions/`), Pottery canonical HE plot: the IsleThorns and AshleyRails
  labels print on top of each other, because their means are close in canonical space.
  - `heplots::heplot.mlm()` always draws the mean labels with `text(..., pos = 3)`
    (`R/heplot.R`, ~line 615), with no way to change it.
  - `heplot.candisc()` passes `factor.means = term` to `heplot()` itself (lines ~234 and ~306),
    so a user can't turn the means off and label them by hand.
  - Fix idea: a `means.pos` argument (recycled over the means, like `label.pos` for the
    ellipses) in `heplot.mlm()`, passed through by `heplot.candisc()`. That needs a heplots
    change first. Possibly also `means.cex` / `means.col`.
