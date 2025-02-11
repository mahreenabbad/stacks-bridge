(impl-trait .sip-010.sip-010-trait);;implement trait

(define-constant ERR-NOT-AUTHORIZED (err u100))
(define-constant ERR-WRONG-PRINCIPAL (err u101))
(define-constant ERR-WRONG-AMOUNT (err u102))
(define-constant PRECISION u6)

(define-data-var token-uri (string-utf8 256) u"")
(define-data-var contract-owner principal contract-caller)

(define-read-only 
	(get-contract-owner)
  	(ok (var-get contract-owner))
)

(define-public 
	(set-contract-owner (owner principal))
	(begin
		(asserts! (is-eq contract-caller (var-get contract-owner)) ERR-NOT-AUTHORIZED)
		(asserts! (not (is-eq owner (var-get contract-owner))) ERR-NOT-AUTHORIZED)
		(ok (var-set contract-owner owner))
	)
)

(define-fungible-token istx)

(define-read-only (get-total-supply)
  	(ok u0)
)

(define-read-only 
	(get-name)
  	(ok "Stacks")
)

(define-read-only 
	(get-symbol)
  (	ok "STX")
)

(define-read-only 
	(get-decimals)
   	(ok PRECISION)
)

(define-read-only 
	(get-balance 
		(account principal)
	)
  	(ok (stx-get-balance account))
)

(define-public 
	(set-token-uri 
		(value (string-utf8 256))
	)
	(begin
		(asserts! (is-eq contract-caller (var-get contract-owner)) ERR-NOT-AUTHORIZED)
		(asserts! (is-eq (> (len value) u0) true) ERR-NOT-AUTHORIZED)
		(ok (var-set token-uri value))
	)
)

(define-read-only 
	(get-token-uri)
  	(ok (some (var-get token-uri)))
)

(define-public 
	(transfer 
		(amount uint) 
		(sender principal) 
		(recipient principal) 
		(memo (optional (buff 34)))
	)
	(begin
		;; (asserts! (is-standard sender) ERR-WRONG-PRINCIPAL)
		(asserts! (not (is-eq sender recipient)) ERR-WRONG-PRINCIPAL)
		(asserts! (is-eq (> amount u0) true) ERR-WRONG-AMOUNT)
		(asserts! (is-eq contract-caller (var-get contract-owner)) ERR-NOT-AUTHORIZED)
		
		(match 
			(stx-transfer?  amount sender recipient)
			response (begin
				(print memo)
				(ok response)
			)
			error (err error)
		)
		
	)
)
