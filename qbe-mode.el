;;; qbe-mode.el - QBE syntax highlighting for GNU Emacs
;; BSD 2-Clause License

;; Keywords for QBE IR
(defvar qbe-font-lock-keywords
  (list
   `(,(regexp-opt
       ;; Function and export
       '("function" "export"

	 ;; Arithmetic and Bits
	 "add" "and" "div" "mul" "neg"
	 "or" "rem" "sar" "shl" "shr"
	 "sub" "udiv" "urem" "xor"

	 ;; Memory
	 "stored" "stores" "storel" "storew"
	 "storeh" "storeb" "store"
	 ;;;; Load
	 "loadd" "loads" "loadl" "loadsw" "loadw"
	 "loaduw" "loadsh" "loaduh" "loadsb"
	 "loadub" "load"
	 ;;;; Bits
	 "blit"
	 ;;;; Stack allocation
	 "alloc4" "alloc8" "alloc16"

	 ;; Comparision
	 "ceqw" "ceql" "ceqs" "ceqd"
	 "cnew" "cnel" "cnes" "cned"
	 "cslew" "cslel" "csles" "csled"
	 "csltw" "csltl" "cslts" "csltd"
	 "csgew" "csgel" "csges" "csged"
	 "csgtw" "csgtl" "csgts" "csgtd"
	 "culew" "culel" "cules" "culed"
	 "cultw" "cultl" "cults" "cultd"
	 "cugew" "cugel" "cuges" "cuged"
	 "cugtw" "cugtl" "cugts" "cugtd"
	 "cles" "cled"
	 "clts" "cltd"
	 "cges" "cged"
	 "cgts" "cgtd"
	 "cos" "cod"
	 "cuos" "cuod"

	 ;; Conversions
	 "dtosi" "dtoui"
	 "exts" "extsb" "extsh" "extsw"
	 "extub" "extuh" "extuw" "sltof"
	 "ultof" "stosi" "stoui" "swtof"
	 "uwtof" "truncd"

	 ;; Cast and Copy
	 "cast" "copy" ;; "wlsd" "sdwl"

	 ;; Call
	 "call"

	 ;; Variadic
	 "vastart" "vaarg"

	 ;; Phi
	 "phi"

	 ;; Jumps
	 "jmp" "jnz" "hlt" "ret"

	 ;; Data
	 "data"

	 ;; Type
	 "type"

	 ;; Align
	 "align"

	 ;; Section
	 "section") 'symbols) . font-lock-keyword-face)

   '("%[-a-zA-Z$._][-a-zA-Z$._0-9]*" . font-lock-variable-name-face)
   '("@[-a-zA-Z.]*" . font-lock-builtin-face)
   `(,(regexp-opt
       ;; Base types
       '("w" "l" "s" "d"
	 ;; Extended types
	 "b" "h"
	 ;; Zero initializer
	 "z"
	 ;; Sub-word types
	 "sb" "ub" "sh" "uh"
	 ;; Other types
	 ;; "opaque" "un[-0-9.]*"
	 ) 'symbols) . font-lock-builtin-face)

   ;; Assigns
   `(,(regexp-opt
       '("=w" "=l" "=s" "=d") 'symbols) . font-lock-reference-face)

   ;; Function names
   '("$[a-zA-Z_.]*" . font-lock-function-name-face)

   ;; Custom type names
   '(":[a-zA-Z_.]*\\|&[a-zA-Z_.]*" . font-lock-type-face)

   ;; Find the leading "#(" and then ending ")#" and mark them as comment.
   ;; Then anything that's after "#" is a comment. Setting face "#" before
   ;; "#(" or ")#" would lead to conflict and so "#(" and ")#" end up, would
   ;; not highlight.
   '("#(" . font-lock-comment-face)
   '(")#" . font-lock-comment-face)
   '("#" . font-lock-comment-face)))

;; Enable prog-mode and fundamental-mode, if they're available
(defalias 'qbe-mode-prog
  (if (fboundp 'prog-mode)
      'prog-mode
    (if (fboundp 'fundamental-mode)
	'fundamental-mode)))

;;;###autoload
(define-derived-mode qbe-mode qbe-mode-prog "QBE"
  "Set new defaults for this specified"
  (setq font-lock-defaults `(qbe-font-lock-keywords))
  (setq-local comment-start "#(")
  (setq-local comment-end ")#")
  uncomment-region-function)

;;;###autoload
(add-to-list 'auto-mode-alist (cons "\\.ssa\\'" 'qbe-mode))
(provide 'qbe-mode)
