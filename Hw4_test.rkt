(sequence 0 5 1) ;(list 0 1 2 3 4 5)

(string-append-map
                  (list "dan" "dog" "curry" "dog2")
                  ".jpg"); '("dan.jpg" "dog.jpg" "curry.jpg" "dog2.jpg") 
(list-nth-mod (list 0 1 2 3 4) 2); 2 

(stream-for-n-steps ones 2) ;(list 1 1)

(stream-for-n-steps funny-number-stream 16) ;(list 1 2 3 4 -5 6 7 8 9 -10 11 12 13 14 -15 16) 

(stream-for-n-steps dan-then-dog 1) ;(list "dan.jpg")

(stream-for-n-steps (stream-add-zero ones) 1) ;(list (cons 0 1))

(stream-for-n-steps (cycle-lists (list 1 2 3) (list "a" "b")) 3) ;(list (cons 1 "a") (cons 2 "b") (cons 3 "a"))
                
(vector-assoc 4 (vector (cons 2 1) (cons 3 1) (cons 4 1) (cons 5 1))) ;(cons 4 1)

((cached-assoc (list (cons 1 2) (cons 3 4)) 3) 3) ;(cons 3 4)
  