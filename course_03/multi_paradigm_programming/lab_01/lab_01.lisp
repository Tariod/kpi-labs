#|
  Mykhailov Dmytro, IP-71, opt. 21
|#
(defparameter list1 '(T HJ JH K L (K)))
(defparameter list2 '(6 7 5 4 (8 9 0) (4 6)))
(defparameter list3 '(K 2 T F G H))

#|
  Задание 1.
    Описать неименованную функцию для объединения голов трех списков в один список:
    1) (T HJ JH K L (K))
    2) (6 7 5 4 (8 9 0) (4 6))
    3) (K 2 T F G H)
|#
(write (
  (lambda (l1 l2 l3)
    (LIST (CAR l1) (CAR l2) (CAR l3))
  ) list1 list2 list3
))

#|
  Задание 2.
    Описать именованную функцию для создания нового списка из элементов
    нескольких исходных списков. В качестве исходных списков использовать
    списки Задания 1. Номера элементов списков: 2, 6, 3.
|#
(defun second_sixth_third (l1 l2 l3)
  (LIST
    (CADR l1)
    (CADDR (CDDDR l2))
    (CADDR l3)
  )
)

(print (
  second_sixth_third list1 list2 list3
))

#|
  Задание 3.
    Есть список lst, описывающий вызов арифметической функции. Написать
    функцию, которая в случае четности результата вычесления lst
    производит его проверку на положительность, а в противном случае
    выдает сам lst. Вычисление lst производить с помощью встроенной
    функции eval.
|#

(defun funcall_example (lst callback)
  (cond
    ((evenp (funcall callback lst))
      (> (funcall callback lst) 0))
    (T lst)
  )
)

(print (funcall_example '(1 2 3) 'CAR))
(print (funcall_example '(4 1 2 3) 'CAR))
(terpri)
