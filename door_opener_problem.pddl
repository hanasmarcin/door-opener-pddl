(define (problem door_opener_problem)
    
    (:domain 
        door_opener
    )
    
    (:objects
        gr gl - gripper
        c1 c2 - cabinet
        h1 h2 - handle
        s11 s12 s13 s21 s22 - shelf
        j1 j2 j3 j4 - jar
        b1 b2 - bin
    )
    
    (:init
        (attached-to h1 c1)
        (attached-to h2 c2)
        
        (directed gr right)
        (directed gl left)
        
        (directed h1 right)
        (directed h2 left)
        
        (attached-to s11 c1)
        (attached-to s12 c1)
        (attached-to s13 c1)
        (attached-to s21 c2)
        (attached-to s22 c2)

        (located s12 j1)
        (located s13 j2)
        (located s21 j3)
        (located s22 j4)
    )

    (:goal (and
        ; (opened c1)
        (not (opened c1))
        (not (opened c2))
        (located b2 j1)
        (located b1 j2)
        (located b2 j3)
        ; (located b1 j4)
        ; (exists (?g - gripper) (located ?g j1))
        ; (not (exists (?o - grippable) (located gr ?o)))
        ; (not (exists (?o - grippable) (located gl ?o)))

    ))
)
