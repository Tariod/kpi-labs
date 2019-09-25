#|
  Задание 1
    Опишите функцию, аргументами которой являются два множества,
    а результатом - множество, содержащее элементы, принадлежащие
    только одному из исходных множеств.
|#

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

(defun my_symmetric_difference (set1 set2)
  (my_complement
    (my_union set2 set1)
    (my_intersection set1 set2)
  )
)

(write (my_symmetric_difference '(1 2 3 4 5) '(4 5 6 7 8)))
(print (my_symmetric_difference '(1 2 3 4 5) '()))
(print (my_symmetric_difference '() '()))

#|
  Задание 2
    Написать программу сортировки списка методом Шелла. Вычисление
    последовательности шагов сортировки производится в соответствии
    с вариантом:
      17-25. Методом, предложенным Дональдом Кнутом.
|#

#|
  Задание 3
    Написать программу сортировки списка в соответствии с
    вариантом:
      3. Сортировка методом прямого выбора.
|#

(defun extreme_element (el lst predicate)
  (if (and (numberp el) (listp lst))
    (if (and (listp lst) (> (length lst) 0))
      (if (funcall predicate (car lst) el)
          (extreme_element (car lst) (cdr lst) predicate)
          (extreme_element el (cdr lst) predicate)
      )
      el
    )
  )
)

(defun remove_by_value (el lst)
  (cond
    ((null lst) NIL)
    ((equal el (car lst)) (cdr lst))
    (T (append (list (car lst)) (remove_by_value el (cdr lst))))
  )
)

(defun selection_sort (lst predicate)
  (if (not (null lst))
    (append
      (list (extreme_element (car lst) (cdr lst) predicate))
      (selection_sort
        (remove_by_value
          (extreme_element (car lst) (cdr lst) predicate)
          lst
        ) predicate
      )
    )
  )
)

(print (selection_sort '(301 132 1750 57 23 701 10 4 1) '>))
(print (selection_sort '(301 132 1750 57 23 701 10 4 1) '<))

#|
  Задание 4
    Написать программу объединения двух отсортированных
    списков в один. При этом порядок сортировки в
    списке-результате должен сохраняться.
|#

(defun sorting_direction (lst)
  (cond
    ((or (not (listp lst)) (= (length lst) 0)) NIL)
    ((< (length lst) 2) "=")
    (T
      (cond
        ((< (car lst) (cadr lst)) "<")
        ((> (car lst) (cadr lst)) ">")
        (T (sorting_direction (cdr lst)))
      )
    )
  )
)

(defun concat_with_sort (lst1 lst2)
  (cond
    ((equal (sorting_direction lst1) "<") (selection_sort (append lst1 lst2) '<))
    ((equal (sorting_direction lst1) ">") (selection_sort (append lst1 lst2) '>))
    ((equal (sorting_direction lst1) "=")
      (cond
        ((equal (sorting_direction lst2) "<") (selection_sort (append lst1 lst2) '<))
        ((equal (sorting_direction lst2) ">") (selection_sort (append lst1 lst2) '>))
        ((equal (sorting_direction lst2) "=") (selection_sort (append lst1 lst2) '>))
        (T NIL)
      )
    )
    (T NIL)
  )
)

(print (concat_with_sort '(1 2 3 4) '(4 5 6 7)))
(print (concat_with_sort '(4 3 2 1) '(7 6 5 4)))
(print (concat_with_sort '(2 2 2 2) '(7 6 5 4)))

#|
  Задание 5
    Написать программу в соответствии с заданием:
      Написать функцию, удаляющую из исходного списка
      подсписки заданной глубины.
|#

(terpri)
