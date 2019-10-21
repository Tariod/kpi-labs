;; Save/load key-value storage:

(defun save-db(path db)
  (with-open-file (out path :direction :output :if-exists :supersede :if-does-not-exist :create)
    (with-standard-io-syntax (print db out))
    (format out "~%")
  )
  db
)

(defun load-db(path)
  (with-open-file (in path)
    (with-standard-io-syntax (read in))
  )
)

;; Check structures:

(defun check-tuple-type(tuple)
  (if (listp tuple)
    tuple
    (error "Tuple is not type List")
  )
)

(defun check-structure(tuple)
  (if (and (listp (car tuple)) (equal (length (car tuple)) 2))
    tuple
    (error "Structure (key value) violated")
  )
)

(defun check-kvstorage-type(kvstorage)
  (if (listp kvstorage)
    kvstorage
    (error "Key-value storage is not type List.")
  )
)

(defun check-path(path)
  (if (listp path)
    path
    (error "Path is not type List.")
  )
)

;; Tuple:

(defun tuple-init()
  NIL
)

(defun tuple-delete(tuple key)
  (if (not (null (check-tuple-type tuple)))
    (if (equal (caar (check-structure tuple)) key)
      (cdr tuple)
      (cons (car tuple) (tuple-delete (cdr tuple) key))
    )
  )
)

(defun tuple-get(tuple key)
  (if (not (null (check-tuple-type tuple)))
    (if (equal (caar (check-structure tuple)) key)
      (cadar tuple)
      (tuple-get (cdr tuple) key)
    )
  )
)

(defun tuple-has(tuple key)
  (if (not (null (check-tuple-type tuple)))
    (if (equal (caar (check-structure tuple)) key)
      T
      (tuple-has (cdr tuple) key)
    )
  )
)

(defun tuple-set(tuple key value)
  (if (not (null (check-tuple-type tuple)))
    (if (equal (caar (check-structure tuple)) key)
      (cons (list key value) (cdr tuple))
      (cons (car tuple) (tuple-set (cdr tuple) key value))
    )
    (list (list key value))
  )
)

;; Key-value storage:

(defun kvstorage-init()
  NIL
)

(defun kvstorage-size(kvstorage)
  (length (check-kvstorage-type kvstorage))
)

(defun kvstorage-clear(kvstorage)
  NIL
)

(defun kvstorage-keys(kvstorage)
  (if (not (null (check-kvstorage-type kvstorage)))
    (cons (caar (check-structure kvstorage)) (kvstorage-keys (cdr kvstorage)))
  )
)

(defun kvstorage-delete(kvstorage path key)
  (if (not (null (check-kvstorage-type kvstorage)))
    (if (null (check-path path))
      (tuple-delete kvstorage key)
      (if (equal (caar (check-structure kvstorage)) (car path))
        (if (null (cdr path))
          (if (and (listp (cadar kvstorage)) (equal (length (caadar kvstorage)) 2) (keywordp (caaar (cdar kvstorage))))
            (cons (list (caar kvstorage) (tuple-delete (cadar kvstorage) key)) (cdr kvstorage))
            (error "Wrong path.")
          )
          (cons (list (caar kvstorage) (kvstorage-delete (cadar kvstorage) (cdr path) key)) (cdr kvstorage))
        )
        (cons (car kvstorage) (kvstorage-delete (cdr kvstorage) path key))
      )
    )
    (if (not (null (check-path path)))
      (error "Wrong path.")
    )
  )
)

(defun kvstorage-get(kvstorage path key)
  (if (not (null (check-kvstorage-type kvstorage)))
    (if (null (check-path path))
      (tuple-get kvstorage key)
      (if (equal (caar (check-structure kvstorage)) (car path))
        (if (null (cdr path))
          (if (and (listp (cadar kvstorage)) (equal (length (caadar kvstorage)) 2) (keywordp (caaar (cdar kvstorage))))
            (tuple-get (cadar kvstorage) key)
            (error "Wrong path.")
          )
          (kvstorage-get (cadar kvstorage) (cdr path) key)
        )
        (kvstorage-get (cdr kvstorage) path key)
      )
    )
    (if (not (null (check-path path)))
      (error "Wrong path.")
    )
  )
)

(defun kvstorage-has(kvstorage path key)
  (if (not (null (check-kvstorage-type kvstorage)))
    (if (null (check-path path))
      (tuple-has kvstorage key)
      (if (equal (caar (check-structure kvstorage)) (car path))
        (if (null (cdr path))
          (if (and (listp (cadar kvstorage)) (equal (length (caadar kvstorage)) 2) (keywordp (caaar (cdar kvstorage))))
            (tuple-has (cadar kvstorage) key)
            (error "Wrong path.")
          )
          (kvstorage-has (cadar kvstorage) (cdr path) key)
        )
        (kvstorage-has (cdr kvstorage) path key)
      )
    )
    (if (not (null (check-path path)))
      (error "Wrong path.")
    )
  )
)

(defun kvstorage-set(kvstorage path key value)
  (if (not (null (check-kvstorage-type kvstorage)))
    (if (null (check-path path))
      (tuple-set kvstorage key value)
      (if (equal (caar (check-structure kvstorage)) (car path))
        (if (null (cdr path))
          (if (and (listp (cadar kvstorage)) (equal (length (caadar kvstorage)) 2) (keywordp (caaar (cdar kvstorage))))
            (cons (list (caar kvstorage) (tuple-set (cadar kvstorage) key value)) (cdr kvstorage))
            (cons (list (caar kvstorage) (tuple-set (tuple-init) key value)) (cdr kvstorage))
          )
          (cons (list (caar kvstorage) (kvstorage-set (cadar kvstorage) (cdr path) key value)) (cdr kvstorage))
        )
        (cons (car kvstorage) (kvstorage-set (cdr kvstorage) path key value))
      )
    )
    (if (null (check-path path))
      (list (list key value))
      (error "Wrong path.")
    )
  )
)

(defun kvstorage-find(kvstorage path key callback)
  (remove-if-not callback (kvstorage-get kvstorage path key))
)

(defun kvstorage-sort(kvstorage path key callback)
  (sort (kvstorage-get kvstorage path key) callback)
)