(defun my_union (set1 set2)
  (cond
    ((null set1) set2)
    ((null set2) set1)
    ((null (member (car set1) set2))
      (append (list (car set1)) (my_union (cdr set1) set2)))
    (T (my_union (cdr set1) set2))
  )
)
