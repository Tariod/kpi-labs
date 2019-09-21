(defun my_intersection (set1 set2)
  (cond
    ((null set1) NIL)
    ((null set2) NIL)
    ((member (car set1) set2)
      (append (my_intersection (cdr set1) set2) (list (car set1))))
    (T (my_intersection (cdr set1) set2))
  )
)
