(load "./lab_03.lisp")
;; Tests:

;; Set test
(write "Set test")
(print
  (kvstorage-set
    (kvstorage-set
      (kvstorage-set
        (kvstorage-init)
        '()
        :T1
        1
      )
      '()
      :T2
      2
    )
    '(:T2)
    :T3
    3
  )
)
;; Set test
(print
  (kvstorage-set
    (kvstorage-set
      (kvstorage-set
        (kvstorage-set
          (kvstorage-set
            (kvstorage-init)
            '()
            :T1
            1
          )
          '()
          :T2
          2
        )
        '(:T1)
        :T3
        3
      )
      '(:T1)
      :T4
      4
    )
    '(:T1 :T3)
    :T5
    5
  )
)
;; Set test
(print
  (kvstorage-set
    (kvstorage-set
      (kvstorage-set
        (kvstorage-set
          (kvstorage-set
            (kvstorage-set
              (kvstorage-init)
              '()
              :T1
              1
            )
            '()
            :T2
            2
          )
          '(:T1)
          :T3
          3
        )
        '(:T1)
        :T4
        4
      )
      '(:T1 :T3)
      :T5
      5
    )
    '()
    :T1
    1
  )
)
;; Get/has test
(print "Get/has test")
(print
  (kvstorage-get
    '((:T1 ((:T3 ((:T5 5))) (:T4 4))) (:T2 2))
    '(:T1 :T3)
    :T5
  )
)
;; Delete test
(print "Delete test")
(print
  (kvstorage-delete
    '((:T1 ((:T3 ((:T5 5))) (:T4 4))) (:T2 2))
    '(:T1 :T3)
    :T5
  )
)
;; Delete test
(print
  (kvstorage-set
    (kvstorage-delete
      '((:T1 ((:T3 ((:T5 5))) (:T4 4))) (:T2 2))
      '(:T1 :T3)
      :T5
    )
    '(:T1)
    :T3
    3
  )
)
;; Keys test
(print "Keys test")
(print
  (kvstorage-keys '((:T1 ((:T3 ((:T5 5))) (:T4 4))) (:T2 2)))
)
;; Keys test
(print
  (kvstorage-keys (kvstorage-get '((:T1 ((:T3 ((:T5 5))) (:T4 4))) (:T2 2)) '() :T1))
)
;; Find test
(print "Find test")
(print
  (kvstorage-find
    '((:T1 ((:T3 ((:T5 (1 2 3 4 5)))) (:T4 4))) (:T2 2))
    '(:T1 :T3)
    :T5
    'evenp
  )
)
;; Sort test
(print "Sort test")
(print
  (kvstorage-find
    '((:T1 ((:T3 ((:T5 (1 2 3 4 5)))) (:T4 4))) (:T2 2))
    '(:T1 :T3)
    :T5
    '<
  )
)
;; Save
(print "Save test")
(print (
  save-db
    "output.txt"
    (kvstorage-set
      (kvstorage-delete
        '((:T1 ((:T3 ((:T5 5))) (:T4 4))) (:T2 2))
        '(:T1 :T3)
        :T5
      )
      '(:T1)
      :T3
      3
    )
))
;; Load
(print "Load test")
(print (load-db "output.txt"))

(terpri)
