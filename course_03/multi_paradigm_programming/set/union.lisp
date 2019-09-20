(defun my_union (set1 set2)
  (cond
    ((null set2) set1)
    ((null (member (car set2) set1))
      (append (my_union set1 (cdr set2)) (list (car set2))))
    (T (my_union set1 (cdr set2)))
  )
)
