;; bridge token trait
;; combines sip-010 and ownable traits

;; (use-trait 'STXWGJQ101N1C1FYHK64TGTHN4793CHVKRW3ZGVV.sip-010.sip-010-trait)
;; (use-trait ownable-trait .ownable-trait.ownable-trait)

(define-trait bridge-token-trait
  (
    (transfer (uint principal principal (optional (buff 34))) (response bool uint))
    (get-name () (response (string-ascii 32) uint))
    (get-symbol () (response (string-ascii 32) uint))
    (get-decimals () (response uint uint))
    (get-balance (principal) (response uint uint))
    (get-total-supply () (response uint uint))
    (get-token-uri () (response (optional (string-utf8 256)) uint))
    (get-contract-owner () (response principal uint))
    (set-contract-owner (principal) (response bool uint))
  )
)