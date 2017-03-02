# class to translate player moves into board array positions
# - allows player to specify plain language positions instead of obtuse array indexes
#
#           Board Layout
#    -----------------------------
#    Indexes      |   Positions
#    0   1   2    |   t1  t2  t3
#    3   4   5    |   m1  m2  m3
#    6   7   8    |   b1  b2  b3
#    -----------------------------
#    Rows            Columns
#    - top = t       - left = 1
#    - middle = m    - center = 2
#    - bottom = b    - right = 3
#    -----------------------------

