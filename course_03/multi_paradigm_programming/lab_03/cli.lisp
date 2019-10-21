(load "./lab_03.lisp")

(defun read-callback()
  (eval (read))
)

(defun cli(db cmd)
  (cond
    ((equal cmd 'exit)
      (write-line "bye")
    )
    ((equal cmd 'load)
      (let ((temp-db (load-db (read))))
        (write temp-db)
        (terpri)
        (cli temp-db (read))
      )
    )
    ((equal cmd 'save)
      (cli (save-db (read) db) (read))
    )
    ((equal cmd 'clear)
      (cli (kvstorage-clear db) (read))
    )
    ((equal cmd 'set)
      (let ((temp-db (kvstorage-set db (read) (read) (read))))
        (write temp-db)
        (terpri)
        (cli temp-db (read))
      )
    )
    ((equal cmd 'has)
      (let ((res (kvstorage-has db (read) (read))))
        (write res)
        (terpri)
        (cli db (read))
      )
    )
    ((equal cmd 'get)
      (let ((res (kvstorage-get db (read) (read))))
        (write res)
        (terpri)
        (cli db (read))
      )
    )
    ((equal cmd 'keys)
      (let ((res (kvstorage-keys db (read))))
        (write res)
        (terpri)
        (cli db (read))
      )
    )
    ((equal cmd 'find)
      (let ((res (kvstorage-find db (read) (read) (read-callback))))
        (write res)
        (terpri)
        (cli db (read))
      )
    )
    ((equal cmd 'sort)
      (let ((res (kvstorage-sort db (read) (read) (read-callback))))
        (write res)
        (terpri)
        (cli db (read))
      )
    )
  )
)

(cli (kvstorage-init) (read))