(define (domain door_opener)

    (:requirements
        :negative-preconditions
        :typing
        :disjunctive-preconditions
        
        )
    
    
    (:types
        direction cabinet directed-obj - obj
        gripper handle - directed-obj
        gripper shelf bin - location
        grippable bin - approachable
        handle product - grippable
        handle shelf - attachable
        can jar - product

    )

    (:constants
        left right - direction
    )

    (:predicates
        (attached-to ?a - attachable ?c - cabinet)
        (directed ?g - directed-obj ?dir - direction)
        (located ?l - location ?o - grippable)
        (opened ?c - cabinet)
        (close-to ?g - gripper ?o - approachable)

    )

    (:action move-to-cabinet
        :parameters (?g - gripper ?c - cabinet ?h - handle)
        :precondition (and 
            (exists (?dir - direction) (and (directed ?g ?dir) (directed ?h ?dir)))
            (attached-to ?h ?c) 
            (not (exists (?gr - gripper ?h - handle) (located ?gr ?h)))
            (not (exists (?gr - gripper ?a - approachable) (close-to ?gr ?a)))
            (not (close-to ?g ?h))
        )
        :effect (and
            (close-to ?g ?h)
        )
    )

    (:action move-back
        :parameters (?g - gripper)
        :precondition (and 
            (not (exists (?h - handle) (located ?g ?h)))
            
        )
        :effect (forall (?a - approachable) (not (close-to ?g ?a)))
    )
    
    
    (:action grab-handle
        :parameters (?g - gripper ?c - cabinet ?h - handle)
        :precondition (and 
            (exists (?dir - direction) (and (directed ?g ?dir) (directed ?h ?dir)))
            (attached-to ?h ?c) 
            (close-to ?g ?h) 
            (not (exists (?o - grippable) (located ?g ?o))) 
            (not (opened ?c))
        )
        :effect (located ?g ?h)
    )
    
    (:action open-cabinet
        :parameters (?g - gripper ?c - cabinet ?h - handle)
        :precondition (and 
            (exists (?dir - direction) (and (directed ?g ?dir) (directed ?h ?dir)))
            (attached-to ?h ?c) 
            (located ?g ?h) 
            (not (opened ?c))
        )
        :effect (and (opened ?c) (located ?g ?h))
    )

    (:action close-cabinet
        :parameters (?g - gripper ?c - cabinet ?h - handle)
        :precondition (and 
            (exists (?dir - direction) (and (directed ?g ?dir) (directed ?h ?dir)))
            (not (exists (?gr - gripper ?p - product) (close-to ?gr ?p)))
            (attached-to ?h ?c) 
            (located ?g ?h) 
            (opened ?c)
        )
        :effect (not (opened ?c))
    )

    (:action release-handle
        :parameters (?g - gripper ?c - cabinet ?h - handle)
        :precondition (and 
            (exists (?dir - direction) (and (directed ?g ?dir) (directed ?h ?dir)))
            (attached-to ?h ?c) 
            (located ?g ?h)
        )
        :effect (not (located ?g ?h))
    )

    (:action move-to-product
        :parameters (?g - gripper ?p - product ?c - cabinet ?s - shelf)
        :precondition (and 
            (exists (?h - handle ?dir - direction) (and (attached-to ?h ?c) (directed ?h ?dir)  (not (directed ?g ?dir))))
            (attached-to ?s ?c)
            (opened ?c)
            (not (exists (?a - approachable) (close-to ?g ?a)))
            (not (exists (?o - grippable) (located ?g ?o)))
            (located ?s ?p)
        )
        :effect (close-to ?g ?p)
    )
    
    (:action grab-product-from-shelf
        :parameters (?g - gripper ?p - product ?c - cabinet ?s - shelf)
        :precondition (and 
            (exists (?h - handle ?dir - direction) (and (attached-to ?h ?c) (directed ?h ?dir)  (not (directed ?g ?dir))))
            (attached-to ?s ?c)
            (opened ?c)
            (not (exists (?o - grippable) (located ?g ?o)))
            (located ?s ?p)
            (close-to ?g ?p)
        )
        :effect (and (located ?g ?p) (not (located ?s ?p)))
    )

    (:action move-above-bin
        :parameters (?g - gripper ?b - bin)
        :precondition (and
            (not (exists (?gr - gripper ?h - handle) (located ?gr ?h)))
            (not (exists (?gr - gripper ?a - approachable) (close-to ?gr ?a)))
            (not (close-to ?g ?b))
        )
        :effect (close-to ?g ?b)
    )

    (:action throw-to-bin
        :parameters (?g - gripper ?b - bin ?p - product)
        :precondition (and 
            (close-to ?g ?b)
            (located ?g ?p)
        )
        :effect (and (not (located ?g ?p)) (located ?b ?p))
    )
    
    


    
    
)