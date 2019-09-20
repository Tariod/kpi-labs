(defun my_member (atm set)
  (cond
    ((null set) NIL)
    ((null (atom atm)) NIL)
    ((null (listp set)) NIL)
    ((equal atm (car set)) set)
    (T (my_member atm (cdr set)))
  )
)
