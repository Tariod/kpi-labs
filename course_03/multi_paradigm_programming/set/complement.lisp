(defun my_complement(set1 set2)
  (cond
    ((null set1) NIL)
    ((null set2) set1)
    ((null (member (car set1) set2))
      (append (my_complement (cdr set1) set2) (list (car set1))))
    (T (my_complement (cdr set1) set2))
  )
)
