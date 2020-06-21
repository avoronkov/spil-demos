#!/usr/bin/env spil
(use std)
(use "fractal.lisp")
(use "snake.lisp")


(def output-filename (filename:str) :str
	 (append filename ".png") :str)


(def main (filename:str)
	 (set' file (open filename))
	 (set fr (fractal-parse file))
	 (set moves (expand-fractal fr))

	 (set dir (point 10.0 0.0))
	 (set snake (make-snake moves (angle fr) dir))
	 (set nsnake (normalize-snake snake 10.0))
	 (set size (canvas-size nsnake 10.0))

	 (set output (output-filename filename))

	 (set' drawer (drawer.new output (first size) (second size)))
	 (draw-snake drawer nsnake)
	 (print "fractal is stored in" output))


;; The program starts here:
(if (or (= __args '()) (= (first __args) "-h") (= (first __args) "--help"))
  (do
	(print "usage: <fractal-file>")
	(print "e.g.:")
	(print "$ ./main.lisp examples/koch-snowflake.txt"))
  (main (first __args)))
