(defun my_member (atm set)
  (cond
    ((null set) NIL)
    ((null (atom atm)) NIL)
    ((null (listp set)) NIL)
    ((equal atm (car set)) set)
    (T (my_member atm (cdr set)))
  )
)

(defun my_complement(set1 set2)
  (cond
    ((null set1) NIL)
    ((null set2) set1)
    ((null (my_member (car set1) set2))
      (append (my_complement (cdr set1) set2) (list (car set1))))
    (T (my_complement (cdr set1) set2))
  )
)

(defun my_union (set1 set2)
  (cond
    ((null set1) set2)
    ((null set2) set1)
    ((null (my_member (car set1) set2))
      (append (list (car set1)) (my_union (cdr set1) set2)))
    (T (my_union (cdr set1) set2))
  )
)

(defun my_intersection (set1 set2)
  (cond
    ((null set1) NIL)
    ((null set2) NIL)
    ((my_member (car set1) set2)
      (append (my_intersection (cdr set1) set2) (list (car set1))))
    (T (my_intersection (cdr set1) set2))
  )
)
