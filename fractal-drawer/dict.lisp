(use std)

(contract :b)

(deftype :pair[a,b] :list)

(def pair  (l:a r:b) :pair[a,b] (list l r) :pair[a,b])
(def left  (p:pair[a,b]) :a (head p) :a)
(def right (p:pair[a,b]) :b (head (tail p)) :b)

(deftype :dict[a,b] :list)

(def dict.contains (key:a '()) :bool false)
(def dict.contains (key:a d:dict[a,b]) :bool
	 (set h (head d) :pair[a,b])
	 (if (= (left h) key)
	   true
	   (dict.contains key (tail d))))

;; add key-value pair into dictionary
(def dict.add (key:a val:b '()) :dict[a,b]
	 (list (pair key val)) :dict[a,b])
(def dict.add (key:a val:b d:dict[a,b]) :dict[a,b]
	 (if (dict.contains key d)
	   d
	   (append d (pair key val))) :dict[a,b])

;; get value by key from dictionary or default value if does not exist
(def dict.getdefault (key:a '() def:b) :b def)
(def dict.getdefault (key:a d:dict[a,b] def:b) :b
	 (set h (head d) :pair[a,b])
	 (if (= (left h) key)
	   (right h)
	   (dict.getdefault key (do (tail d) :dict[a,b]) def)) :b)
	 
;; set value in dictionary by key
(def dict.set (key:a val:b '()) :dict[a,b]
	 (list (pair key val)) :dict[a,b])
(def dict.set (key:a val:b d:dict[a,b]) :dict[a,b]
	 (dict.set key val '() d))
(def dict.set (key:a val:b l:list '()) :dict[a,b]
	 (append l (pair key val)) :dict[a,b])

(def dict.set (key:a val:b l:list r:list) :dict[a,b]
	 (set h (head r) :pair[a,b])
	 (if (= (left h) key)
	   (reduce \(append _2 _1) (tail r) (append l (pair key val )))
	   (dict.set key val (append l h) (tail r))) :dict[a,b])
; (def expect-int (x:int) :str "OK")
; 
; (set p (pair 13 "hello"))
; 
; (print (expect-int (left p)))
; 
; (set d (dict.set 13 "foo" '()))
; (set d1 (dict.set 14 "bar" d))
; (set d2 (dict.set 13 "baz" d1))
; 
; (print "dict:" d2 (type d2))
; (print "13:" (dict.getdefault 13 d2 ""))
