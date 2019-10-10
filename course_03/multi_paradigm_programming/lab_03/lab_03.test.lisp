(load "./lab_03.lisp")
;; Tests:

;; Set test
(write
  (kvstorage-set
    (kvstorage-set
      (kvstorage-set
        (kvstorage-init)
        '()
        :t1
        1
      )
      '()
      :t2
      2
    )
    '(:t2)
    :t3
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
            :t1
            1
          )
          '()
          :t2
          2
        )
        '(:t1)
        :t3
        3
      )
      '(:t1)
      :t4
      4
    )
    '(:t1 :t3)
    :t5
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
              :t1
              1
            )
            '()
            :t2
            2
          )
          '(:t1)
          :t3
          3
        )
        '(:t1)
        :t4
        4
      )
      '(:t1 :t3)
      :t5
      5
    )
    '()
    :t1
    1
  )
)
;; Get/has test
(print
  (kvstorage-get
    '((:T1 ((:T3 ((:T5 5))) (:T4 4))) (:T2 2))
    '(:t1 :t3)
    :t5
  )
)
;; Delete test
(print
  (kvstorage-delete
    '((:T1 ((:T3 ((:T5 5))) (:T4 4))) (:T2 2))
    '(:t1 :t3)
    :t5
  )
)
;; Delete test
(print
  (kvstorage-set
    (kvstorage-delete
      '((:T1 ((:T3 ((:T5 5))) (:T4 4))) (:T2 2))
      '(:t1 :t3)
      :t5
    )
    '(:t1)
    :t3
    3
  )
)
;; Save
(save-db
  "output.txt"
  (kvstorage-set
    (kvstorage-delete
      '((:T1 ((:T3 ((:T5 5))) (:T4 4))) (:T2 2))
      '(:t1 :t3)
      :t5
    )
    '(:t1)
    :t3
    3
  )
)
;; Load
(print (load-db "output.txt"))

(terpri)
