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
      (cons (car set1) (my_union (cdr set1) set2)))
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

#|
  Задание 2
    Написать программу сортировки списка методом Шелла. Вычисление
    последовательности шагов сортировки производится в соответствии
    с вариантом:
      17-25. Методом, предложенным Дональдом Кнутом.
|#

(defun insert_by_index (index value lst)
  (cond
    ((equal index 0) (cons value lst))
    ((null lst) NIL)
    (T (cons (car lst) (insert_by_index (- index 1) value (cdr lst))))
  )
)

(defun remove_by_index (index lst)
  (cond
    ((null lst) NIL)
    ((equal index 0) (cdr lst))
    (T (cons (car lst) (remove_by_index (- index 1) (cdr lst))))
  )
)

(defun my_swap (lst i j)
  (insert_by_index
    i
    (nth j lst)
    (remove_by_index
      j
      (remove_by_index
        i
        (insert_by_index
          j
          (nth i lst)
          lst
        )
      )
    )
  )
)

(defun steps (lst)
  (if (not (equal (- (truncate (log (length lst) 2)) 1) 0))
    (- (truncate (log (length lst) 2)) 1)
    1
  )
)

(defun first_gap (stp gap)
  (if (> stp 1)
    (first_gap (- stp 1) (+ (* 2 gap) 1))
    gap
  )
)

(defun loop3 (lst j gap predicate)
  (if (and (>= j 0) (funcall predicate (nth (+ j gap) lst) (nth j lst)))
    (loop3 (my_swap lst j (+ j gap)) (- j gap) gap predicate)
    lst
  )
)

(defun loop2 (lst i gap predicate)
  (if (< i (length lst))
    (loop2 (loop3 lst (- i gap) gap predicate) (+ i 1) gap predicate)
    lst
  )
)

(defun loop1 (lst stp gap predicate)
  (if (> stp 0)
    (loop1 (loop2 lst gap gap predicate) (- stp 1) (/ (- gap 1) 2) predicate)
    lst
  )
)

(defun shellsort (lst predicate)
  (if (not (null lst))
    (loop1
      lst
      (steps lst)
      (first_gap (steps lst) 1)
      predicate
    )
  )
)

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
    (T (cons (car lst) (remove_by_value el (cdr lst))))
  )
)

(defun selection_sort (lst predicate)
  (if (not (null lst))
    (cons
      (extreme_element (car lst) (cdr lst) predicate)
      (selection_sort
        (remove_by_value
          (extreme_element (car lst) (cdr lst) predicate)
          lst
        ) predicate
      )
    )
  )
)

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

#|
  Задание 5
    Написать программу в соответствии с заданием:
      Написать функцию, удаляющую из исходного списка
      подсписки заданной глубины.
|#

(defun depth_clone (lst depth)
  (cond
    ((null lst) NIL)
    ((listp (car lst))
      (if (> depth 0)
        (cons (depth_clone (car lst) (- depth 1)) (depth_clone (cdr lst) depth))
        (depth_clone (cdr lst) depth)
      )
    )
    (T (cons (car lst) (depth_clone (cdr lst) depth)))
  )
)

#|
  Usage
|#

(write "Task 1")
(print (my_symmetric_difference '(1 2 3 4 5) '(4 5 6 7 8)))
(print (my_symmetric_difference '(1 2 3 4 5) '()))
(print (my_symmetric_difference '() '()))

(print "Task 2")
(print (shellsort '() '<))
(print (shellsort '() '>))
(print (shellsort '(1) '<))
(print (shellsort '(1) '>))
(print (shellsort '(2 1) '<))
(print (shellsort '(1 2) '>))
(print (shellsort '(1 2 3 4 5) '<))
(print (shellsort '(5 4 3 2 1) '>))
(print (shellsort '(89 16 93 6 30 54 26 34 13 78 3 40 51 12 93 76 12 13 11 50) '<))
(print (shellsort '(89 16 93 6 30 54 26 34 13 78 3 40 51 12 93 76 12 13 11 50) '>))

(print "Task 3")
(print (selection_sort '(301 132 1750 57 23 701 10 4 1) '>))
(print (selection_sort '(301 132 1750 57 23 701 10 4 1) '<))

(print "Task 4")
(print (concat_with_sort '(1 2 3 4) '(4 5 6 7)))
(print (concat_with_sort '(4 3 2 1) '(7 6 5 4)))
(print (concat_with_sort '(2 2 2 2) '(7 6 5 4)))

(print "Task 5")
(print (depth_clone '(1 2 3 ((4) ((5) (6) 7)) 8) 0))
(print (depth_clone '(1 2 3 ((4) ((5) (6)) 7) 8) 1))
(print (depth_clone '(1 2 3 ((4) ((5) (6) 7)) 8) 2))
(print (depth_clone '(1 2 3 ((4) ((5) (6) 7)) 8) 3))
(print (depth_clone '(1 2 3 ((4) (5))) 1))

(terpri)
