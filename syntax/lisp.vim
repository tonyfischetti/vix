" Vim syntax file
" Language:    Lisp
" Maintainer:  Dr. Charles E. Campbell, Jr. <NdrOchipS@PcampbellAfamily.Mbiz>
" Last Change: Nov 16, 2010
" Version:     22
" URL:	       http://mysite.verizon.net/astronaut/vim/index.html#vimlinks_syntax
"
"  Thanks to F Xavier Noria for a list of 978 Common Lisp symbols
"  taken from the HyperSpec
"  Clisp additions courtesy of http://clisp.cvs.sourceforge.net/*checkout*/clisp/clisp/emacs/lisp.vim

" ---------------------------------------------------------------------
"  Load Once: {{{1
" For vim-version 5.x: Clear all syntax items
" For vim-version 6.x: Quit when a syntax file was already loaded
if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

if version >= 600
 setlocal iskeyword=38,42,43,45,47-58,60-62,64-90,97-122,_
else
 set iskeyword=38,42,43,45,47-58,60-62,64-90,97-122,_
endif

if exists("g:lispsyntax_ignorecase") || exists("g:lispsyntax_clisp")
 set ignorecase
endif

" ---------------------------------------------------------------------
" Clusters: {{{1
syn cluster			lispAtomCluster		contains=lispAtomBarSymbol,lispAtomList,lispAtomNmbr0,lispComment,lispDecl,lispFunc,lispLeadWhite
syn cluster			lispBaseListCluster	contains=lispAtom,lispAtomBarSymbol,lispAtomMark,lispBQList,lispBarSymbol,lispComment,lispConcat,lispDecl,lispFunc,lispKey,lispList,lispNumber,lispEscapeSpecial,lispSymbol,lispVar,lispLeadWhite
if exists("g:lisp_instring")
 syn cluster			lispListCluster		contains=@lispBaseListCluster,lispString,lispInString,lispInStringString
else
 syn cluster			lispListCluster		contains=@lispBaseListCluster,lispString
endif

syn case ignore

" ---------------------------------------------------------------------
" Lists: {{{1
syn match			lispSymbol			contained			![^(){}'`,"; \t]\+!
syn match			lispBarSymbol			contained			!|..\{-}|!
if exists("g:lisp_rainbow") && g:lisp_rainbow != 0
 syn region lispParen0           matchgroup=hlLevel0 start="`\=(" end=")" skip="|.\{-}|" contains=@lispListCluster,lispParen1
 syn region lispParen1 contained matchgroup=hlLevel1 start="`\=(" end=")" skip="|.\{-}|" contains=@lispListCluster,lispParen2
 syn region lispParen2 contained matchgroup=hlLevel2 start="`\=(" end=")" skip="|.\{-}|" contains=@lispListCluster,lispParen3
 syn region lispParen3 contained matchgroup=hlLevel3 start="`\=(" end=")" skip="|.\{-}|" contains=@lispListCluster,lispParen4
 syn region lispParen4 contained matchgroup=hlLevel4 start="`\=(" end=")" skip="|.\{-}|" contains=@lispListCluster,lispParen5
 syn region lispParen5 contained matchgroup=hlLevel5 start="`\=(" end=")" skip="|.\{-}|" contains=@lispListCluster,lispParen6
 syn region lispParen6 contained matchgroup=hlLevel6 start="`\=(" end=")" skip="|.\{-}|" contains=@lispListCluster,lispParen7
 syn region lispParen7 contained matchgroup=hlLevel7 start="`\=(" end=")" skip="|.\{-}|" contains=@lispListCluster,lispParen8
 syn region lispParen8 contained matchgroup=hlLevel8 start="`\=(" end=")" skip="|.\{-}|" contains=@lispListCluster,lispParen9
 syn region lispParen9 contained matchgroup=hlLevel9 start="`\=(" end=")" skip="|.\{-}|" contains=@lispListCluster,lispParen0
else
 syn region lispList			matchgroup=Delimiter start="("   skip="|.\{-}|"			matchgroup=Delimiter end=")"	contains=@lispListCluster
 syn region lispBQList			matchgroup=PreProc   start="`("  skip="|.\{-}|"			matchgroup=PreProc   end=")"		contains=@lispListCluster
endif

" ---------------------------------------------------------------------
" Atoms: {{{1
syn match lispAtomMark			"'"
syn match lispAtomMark			"{"
syn match lispAtomMark			"}"
syn match lispAtom			"'("me=e-1			contains=lispAtomMark	nextgroup=lispAtomList
syn match lispAtom			"'[^ \t()]\+"			contains=lispAtomMark
syn match lispAtomBarSymbol		!'|..\{-}|!			contains=lispAtomMark
syn region lispAtom			start=+'"+			skip=+\\"+ end=+"+
syn region lispAtomList			contained			matchgroup=Special start="("	skip="|.\{-}|" matchgroup=Special end=")"	contains=@lispAtomCluster,lispString,lispEscapeSpecial
syn match lispAtomNmbr			contained			"\<\d\+"
syn match lispLeadWhite			contained			"^\s\+"

" ---------------------------------------------------------------------
" Standard Lisp Functions and Macros: {{{1
syn keyword lispFunc		*				find-method					pprint-indent
syn keyword lispFunc		**				find-package					pprint-linear
syn keyword lispFunc		***				find-restart					pprint-logical-block
syn keyword lispFunc		+				find-symbol					pprint-newline
syn keyword lispFunc		++				finish-output					pprint-pop
syn keyword lispFunc		+++				first						pprint-tab
syn keyword lispFunc		-				fixnum						pprint-tabular
syn keyword lispFunc		/				flet						prin1
syn keyword lispFunc		//				float						prin1-to-string
syn keyword lispFunc		///				float-digits					princ
syn keyword lispFunc		/=				float-precision					princ-to-string
syn keyword lispFunc		1+				float-radix					print
syn keyword lispFunc		1-				float-sign					print-not-readable
syn keyword lispFunc		<				floating-point-inexact				print-not-readable-object
syn keyword lispFunc		<=				floating-point-invalid-operation                print-object
syn keyword lispFunc		=				floating-point-overflow				print-unreadable-object
syn keyword lispFunc		>				floating-point-underflow			probe-file
syn keyword lispFunc		>=				floatp						proclaim
syn keyword lispFunc		abort				floor						prog
syn keyword lispFunc		abs				fmakunbound					prog*
syn keyword lispFunc		access				force-output					prog1
syn keyword lispFunc		acons				format						prog2
syn keyword lispFunc		acos				formatter					progn
syn keyword lispFunc		acosh				fourth						program-error
syn keyword lispFunc		add-method			fresh-line					progv
syn keyword lispFunc		adjoin				fround						provide
syn keyword lispFunc		adjust-array			ftruncate					psetf
syn keyword lispFunc		adjustable-array-p		ftype						psetq
syn keyword lispFunc		allocate-instance		funcall						push
syn keyword lispFunc		alpha-char-p			function					pushnew
syn keyword lispFunc		alphanumericp			function-keywords				putprop
syn keyword lispFunc		and				function-lambda-expression			quote
syn keyword lispFunc		append				functionp					random
syn keyword lispFunc		apply				gbitp						random-state
syn keyword lispFunc		applyhook			gcd						random-state-p
syn keyword lispFunc		apropos				generic-function				rassoc
syn keyword lispFunc		apropos-list			gensym						rassoc-if
syn keyword lispFunc		aref				gentemp						rassoc-if-not
syn keyword lispFunc		arithmetic-error		get						ratio
syn keyword lispFunc		arithmetic-error-operands	get-decoded-time				rational
syn keyword lispFunc		arithmetic-error-operation	get-dispatch-macro-character			rationalize
syn keyword lispFunc		array				get-internal-real-time				rationalp
syn keyword lispFunc		array-dimension			get-internal-run-time				read
syn keyword lispFunc		array-dimension-limit		get-macro-character				read-byte
syn keyword lispFunc		array-dimensions		get-output-stream-string			read-char
syn keyword lispFunc		array-displacement		get-properties					read-char-no-hang
syn keyword lispFunc		array-element-type		get-setf-expansion				read-delimited-list
syn keyword lispFunc		array-has-fill-pointer-p	get-setf-method					read-eval-print
syn keyword lispFunc		array-in-bounds-p		get-universal-time				read-from-string
syn keyword lispFunc		array-rank			getf						read-line
syn keyword lispFunc		array-rank-limit		gethash						read-preserving-whitespace
syn keyword lispFunc		array-row-major-index		go						read-sequence
syn keyword lispFunc		array-total-size		graphic-char-p					reader-error
syn keyword lispFunc		array-total-size-limit		handler-bind					readtable
syn keyword lispFunc		arrayp				handler-case					readtable-case
syn keyword lispFunc		ash				hash-table					readtablep
syn keyword lispFunc		asin				hash-table-count				real
syn keyword lispFunc		asinh				hash-table-p					realp
syn keyword lispFunc		assert				hash-table-rehash-size				realpart
syn keyword lispFunc		assoc				hash-table-rehash-threshold			reduce
syn keyword lispFunc		assoc-if			hash-table-size					reinitialize-instance
syn keyword lispFunc		assoc-if-not			hash-table-test					rem
syn keyword lispFunc		atan				host-namestring					remf
syn keyword lispFunc		atanh				identity					remhash
syn keyword lispFunc		atom				if						remove
syn keyword lispFunc		base-char			if-exists					remove-duplicates
syn keyword lispFunc		base-string			ignorable					remove-if
syn keyword lispFunc		bignum				ignore						remove-if-not
syn keyword lispFunc		bit				ignore-errors					remove-method
syn keyword lispFunc		bit-and				imagpart					remprop
syn keyword lispFunc		bit-andc1			import						rename-file
syn keyword lispFunc		bit-andc2			in-package					rename-package
syn keyword lispFunc		bit-eqv				in-package					replace
syn keyword lispFunc		bit-ior				incf						require
syn keyword lispFunc		bit-nand			initialize-instance				rest
syn keyword lispFunc		bit-nor				inline						restart
syn keyword lispFunc		bit-not				input-stream-p					restart-bind
syn keyword lispFunc		bit-orc1			inspect						restart-case
syn keyword lispFunc		bit-orc2			int-char					restart-name
syn keyword lispFunc		bit-vector			integer						return
syn keyword lispFunc		bit-vector-p			integer-decode-float				return-from
syn keyword lispFunc		bit-xor				integer-length					revappend
syn keyword lispFunc		block				integerp					reverse
syn keyword lispFunc		boole				interactive-stream-p				room
syn keyword lispFunc		boole-1				intern						rotatef
syn keyword lispFunc		boole-2				internal-time-units-per-second			round
syn keyword lispFunc		boole-and			intersection					row-major-aref
syn keyword lispFunc		boole-andc1			invalid-method-error				rplaca
syn keyword lispFunc		boole-andc2			invoke-debugger					rplacd
syn keyword lispFunc		boole-c1			invoke-restart					safety
syn keyword lispFunc		boole-c2			invoke-restart-interactively			satisfies
syn keyword lispFunc		boole-clr			isqrt						sbit
syn keyword lispFunc		boole-eqv			keyword						scale-float
syn keyword lispFunc		boole-ior			keywordp					schar
syn keyword lispFunc		boole-nand			labels						search
syn keyword lispFunc		boole-nor			lambda						second
syn keyword lispFunc		boole-orc1			lambda-list-keywords				sequence
syn keyword lispFunc		boole-orc2			lambda-parameters-limit				serious-condition
syn keyword lispFunc		boole-set			last						set
syn keyword lispFunc		boole-xor			lcm						set-char-bit
syn keyword lispFunc		boolean				ldb						set-difference
syn keyword lispFunc		both-case-p			ldb-test					set-dispatch-macro-character
syn keyword lispFunc		boundp				ldiff						set-exclusive-or
syn keyword lispFunc		break				least-negative-double-float			set-macro-character
syn keyword lispFunc		broadcast-stream		least-negative-long-float			set-pprint-dispatch
syn keyword lispFunc		broadcast-stream-streams	least-negative-normalized-double-float		set-syntax-from-char
syn keyword lispFunc		built-in-class			least-negative-normalized-long-float		setf
syn keyword lispFunc		butlast				least-negative-normalized-short-float		setq
syn keyword lispFunc		byte				least-negative-normalized-single-float		seventh
syn keyword lispFunc		byte-position			least-negative-short-float			shadow
syn keyword lispFunc		byte-size			least-negative-single-float			shadowing-import
syn keyword lispFunc		call-arguments-limit		least-positive-double-float			shared-initialize
syn keyword lispFunc		call-method			least-positive-long-float			shiftf
syn keyword lispFunc		call-next-method		least-positive-normalized-double-float		short-float
syn keyword lispFunc		capitalize			least-positive-normalized-long-float		short-float-epsilon
syn keyword lispFunc		car				least-positive-normalized-short-float		short-float-negative-epsilon
syn keyword lispFunc		case				least-positive-normalized-single-float		short-site-name
syn keyword lispFunc		catch				least-positive-short-float			signal
syn keyword lispFunc		ccase				least-positive-single-float			signed-byte
syn keyword lispFunc		cdr				length						signum
syn keyword lispFunc		ceiling				let						simple-condition
syn keyword lispFunc		cell-error			let*						simple-array
syn keyword lispFunc		cell-error-name			lisp						simple-base-string
syn keyword lispFunc		cerror				lisp-implementation-type			simple-bit-vector
syn keyword lispFunc		change-class			lisp-implementation-version			simple-bit-vector-p
syn keyword lispFunc		char				list						simple-condition-format-arguments
syn keyword lispFunc		char-bit			list*						simple-condition-format-control
syn keyword lispFunc		char-bits			list-all-packages				simple-error
syn keyword lispFunc		char-bits-limit			list-length					simple-string
syn keyword lispFunc		char-code			listen						simple-string-p
syn keyword lispFunc		char-code-limit			listp						simple-type-error
syn keyword lispFunc		char-control-bit		load						simple-vector
syn keyword lispFunc		char-downcase			load-logical-pathname-translations		simple-vector-p
syn keyword lispFunc		char-equal			load-time-value					simple-warning
syn keyword lispFunc		char-font			locally						sin
syn keyword lispFunc		char-font-limit			log						single-flaot-epsilon
syn keyword lispFunc		char-greaterp			logand						single-float
syn keyword lispFunc		char-hyper-bit			logandc1					single-float-epsilon
syn keyword lispFunc		char-int			logandc2					single-float-negative-epsilon
syn keyword lispFunc		char-lessp			logbitp						sinh
syn keyword lispFunc		char-meta-bit			logcount					sixth
syn keyword lispFunc		char-name			logeqv						sleep
syn keyword lispFunc		char-not-equal			logical-pathname				slot-boundp
syn keyword lispFunc		char-not-greaterp		logical-pathname-translations			slot-exists-p
syn keyword lispFunc		char-not-lessp			logior						slot-makunbound
syn keyword lispFunc		char-super-bit			lognand						slot-missing
syn keyword lispFunc		char-upcase			lognor						slot-unbound
syn keyword lispFunc		char/=				lognot						slot-value
syn keyword lispFunc		char<				logorc1						software-type
syn keyword lispFunc		char<=				logorc2						software-version
syn keyword lispFunc		char=				logtest						some
syn keyword lispFunc		char>				logxor						sort
syn keyword lispFunc		char>=				long-float					space
syn keyword lispFunc		character			long-float-epsilon				special
syn keyword lispFunc		characterp			long-float-negative-epsilon			special-form-p
syn keyword lispFunc		check-type			long-site-name					special-operator-p
syn keyword lispFunc		cis				loop						speed
syn keyword lispFunc		class				loop-finish					sqrt
syn keyword lispFunc		class-name			lower-case-p					stable-sort
syn keyword lispFunc		class-of			machine-instance				standard
syn keyword lispFunc		clear-input			machine-type					standard-char
syn keyword lispFunc		clear-output			machine-version					standard-char-p
syn keyword lispFunc		close				macro-function					standard-class
syn keyword lispFunc		clrhash				macroexpand					standard-generic-function
syn keyword lispFunc		code-char			macroexpand-1					standard-method
syn keyword lispFunc		coerce				macroexpand-l					standard-object
syn keyword lispFunc		commonp				macrolet					step
syn keyword lispFunc		compilation-speed		make-array					storage-condition
syn keyword lispFunc		compile				make-array					store-value
syn keyword lispFunc		compile-file			make-broadcast-stream				stream
syn keyword lispFunc		compile-file-pathname		make-char					stream-element-type
syn keyword lispFunc		compiled-function		make-concatenated-stream			stream-error
syn keyword lispFunc		compiled-function-p		make-condition					stream-error-stream
syn keyword lispFunc		compiler-let			make-dispatch-macro-character			stream-external-format
syn keyword lispFunc		compiler-macro			make-echo-stream				streamp
syn keyword lispFunc		compiler-macro-function	make-hash-table						streamup
syn keyword lispFunc		complement			make-instance					string
syn keyword lispFunc		complex				make-instances-obsolete				string-capitalize
syn keyword lispFunc		complexp			make-list					string-char
syn keyword lispFunc		compute-applicable-methods	make-load-form					string-char-p
syn keyword lispFunc		compute-restarts		make-load-form-saving-slots			string-downcase
syn keyword lispFunc		concatenate			make-method					string-equal
syn keyword lispFunc		concatenated-stream		make-package					string-greaterp
syn keyword lispFunc		concatenated-stream-streams	make-pathname					string-left-trim
syn keyword lispFunc		cond				make-random-state				string-lessp
syn keyword lispFunc		condition			make-sequence					string-not-equal
syn keyword lispFunc		conjugate			make-string					string-not-greaterp
syn keyword lispFunc		cons				make-string-input-stream			string-not-lessp
syn keyword lispFunc		consp				make-string-output-stream			string-right-strim
syn keyword lispFunc		constantly			make-symbol					string-right-trim
syn keyword lispFunc		constantp			make-synonym-stream				string-stream
syn keyword lispFunc		continue			make-two-way-stream				string-trim
syn keyword lispFunc		control-error			makunbound					string-upcase
syn keyword lispFunc		copy-alist			map						string/=
syn keyword lispFunc		copy-list			map-into					string<
syn keyword lispFunc		copy-pprint-dispatch		mapc						string<=
syn keyword lispFunc		copy-readtable			mapcan						string=
syn keyword lispFunc		copy-seq			mapcar						string>
syn keyword lispFunc		copy-structure			mapcon						string>=
syn keyword lispFunc		copy-symbol			maphash						stringp
syn keyword lispFunc		copy-tree			mapl						structure
syn keyword lispFunc		cos				maplist						structure-class
syn keyword lispFunc		cosh				mask-field					structure-object
syn keyword lispFunc		count				max						style-warning
syn keyword lispFunc		count-if			member						sublim
syn keyword lispFunc		count-if-not			member-if					sublis
syn keyword lispFunc		ctypecase			member-if-not					subseq
syn keyword lispFunc		debug				merge						subsetp
syn keyword lispFunc		decf				merge-pathname					subst
syn keyword lispFunc		declaim				merge-pathnames					subst-if
syn keyword lispFunc		declaration			method						subst-if-not
syn keyword lispFunc		declare				method-combination				substitute
syn keyword lispFunc		decode-float			method-combination-error			substitute-if
syn keyword lispFunc		decode-universal-time		method-qualifiers				substitute-if-not
syn keyword lispFunc		defclass			min						subtypep
syn keyword lispFunc		defconstant			minusp						svref
syn keyword lispFunc		defgeneric			mismatch					sxhash
syn keyword lispFunc		define-compiler-macro		mod						symbol
syn keyword lispFunc		define-condition		most-negative-double-float			symbol-function
syn keyword lispFunc		define-method-combination	most-negative-fixnum				symbol-macrolet
syn keyword lispFunc		define-modify-macro		most-negative-long-float			symbol-name
syn keyword lispFunc		define-setf-expander		most-negative-short-float			symbol-package
syn keyword lispFunc		define-setf-method		most-negative-single-float			symbol-plist
syn keyword lispFunc		define-symbol-macro		most-positive-double-float			symbol-value
syn keyword lispFunc		defmacro			most-positive-fixnum				symbolp
syn keyword lispFunc		defmethod			most-positive-long-float			synonym-stream
syn keyword lispFunc		defpackage			most-positive-short-float			synonym-stream-symbol
syn keyword lispFunc		defparameter			most-positive-single-float			sys
syn keyword lispFunc		defsetf				muffle-warning					system
syn keyword lispFunc		defstruct			multiple-value-bind				t
syn keyword lispFunc		deftype				multiple-value-call				tagbody
syn keyword lispFunc		defun				multiple-value-list				tailp
syn keyword lispFunc		defvar				multiple-value-prog1				tan
syn keyword lispFunc		delete				multiple-value-seteq				tanh
syn keyword lispFunc		delete-duplicates		multiple-value-setq				tenth
syn keyword lispFunc		delete-file			multiple-values-limit				terpri
syn keyword lispFunc		delete-if			name-char					the
syn keyword lispFunc		delete-if-not			namestring					third
syn keyword lispFunc		delete-package			nbutlast					throw
syn keyword lispFunc		denominator			nconc						time
syn keyword lispFunc		deposit-field			next-method-p					trace
syn keyword lispFunc		describe			nil						translate-logical-pathname
syn keyword lispFunc		describe-object			nintersection					translate-pathname
syn keyword lispFunc		destructuring-bind		ninth						tree-equal
syn keyword lispFunc		digit-char			no-applicable-method				truename
syn keyword lispFunc		digit-char-p			no-next-method					truncase
syn keyword lispFunc		directory			not						truncate
syn keyword lispFunc		directory-namestring		notany						two-way-stream
syn keyword lispFunc		disassemble			notevery					two-way-stream-input-stream
syn keyword lispFunc		division-by-zero		notinline					two-way-stream-output-stream
syn keyword lispFunc		do				nreconc						type
syn keyword lispFunc		do*				nreverse					type-error
syn keyword lispFunc		do-all-symbols			nset-difference					type-error-datum
syn keyword lispFunc		do-exeternal-symbols		nset-exclusive-or				type-error-expected-type
syn keyword lispFunc		do-external-symbols		nstring						type-of
syn keyword lispFunc		do-symbols			nstring-capitalize				typecase
syn keyword lispFunc		documentation			nstring-downcase				typep
syn keyword lispFunc		dolist				nstring-upcase					unbound-slot
syn keyword lispFunc		dotimes				nsublis						unbound-slot-instance
syn keyword lispFunc		double-float			nsubst						unbound-variable
syn keyword lispFunc		double-float-epsilon		nsubst-if					undefined-function
syn keyword lispFunc		double-float-negative-epsilon	nsubst-if-not					unexport
syn keyword lispFunc		dpb				nsubstitute					unintern
syn keyword lispFunc		dribble				nsubstitute-if					union
syn keyword lispFunc		dynamic-extent			nsubstitute-if-not				unless
syn keyword lispFunc		ecase				nth						unread
syn keyword lispFunc		echo-stream			nth-value					unread-char
syn keyword lispFunc		echo-stream-input-stream	nthcdr						unsigned-byte
syn keyword lispFunc		echo-stream-output-stream	null						untrace
syn keyword lispFunc		ed				number						unuse-package
syn keyword lispFunc		eighth				numberp						unwind-protect
syn keyword lispFunc		elt				numerator					update-instance-for-different-class
syn keyword lispFunc		encode-universal-time		nunion						update-instance-for-redefined-class
syn keyword lispFunc		end-of-file			oddp						upgraded-array-element-type
syn keyword lispFunc		endp				open						upgraded-complex-part-type
syn keyword lispFunc		enough-namestring		open-stream-p					upper-case-p
syn keyword lispFunc		ensure-directories-exist	optimize					use-package
syn keyword lispFunc		ensure-generic-function	        or						use-value
syn keyword lispFunc		eq				otherwise					user
syn keyword lispFunc		eql				output-stream-p					user-homedir-pathname
syn keyword lispFunc		equal				package						values
syn keyword lispFunc		equalp				package-error					values-list
syn keyword lispFunc		error				package-error-package				vector
syn keyword lispFunc		etypecase			package-name					vector-pop
syn keyword lispFunc		eval				package-nicknames				vector-push
syn keyword lispFunc		eval-when			package-shadowing-symbols			vector-push-extend
syn keyword lispFunc		evalhook			package-use-list				vectorp
syn keyword lispFunc		evenp				package-used-by-list				warn
syn keyword lispFunc		every				packagep					warning
syn keyword lispFunc		exp				pairlis						when
syn keyword lispFunc		export				parse-error					wild-pathname-p
syn keyword lispFunc		expt				parse-integer					with-accessors
syn keyword lispFunc		extended-char			parse-namestring				with-compilation-unit
syn keyword lispFunc		fboundp				pathname					with-condition-restarts
syn keyword lispFunc		fceiling			pathname-device					with-hash-table-iterator
syn keyword lispFunc		fdefinition			pathname-directory				with-input-from-string
syn keyword lispFunc		ffloor				pathname-host					with-open-file
syn keyword lispFunc		fifth				pathname-match-p				with-open-stream
syn keyword lispFunc		file-author			pathname-name					with-output-to-string
syn keyword lispFunc		file-error			pathname-type					with-package-iterator
syn keyword lispFunc		file-error-pathname		pathname-version				with-simple-restart
syn keyword lispFunc		file-length			pathnamep					with-slots
syn keyword lispFunc		file-namestring			peek-char					with-standard-io-syntax
syn keyword lispFunc		file-position			phase						write
syn keyword lispFunc		file-stream			pi						write-byte
syn keyword lispFunc		file-string-length		plusp						write-char
syn keyword lispFunc		file-write-date			pop						write-line
syn keyword lispFunc		fill				position					write-sequence
syn keyword lispFunc		fill-pointer			position-if					write-string
syn keyword lispFunc		find				position-if-not					write-to-string
syn keyword lispFunc		find-all-symbols		pprint						y-or-n-p
syn keyword lispFunc		find-class			pprint-dispatch					yes-or-no-p
syn keyword lispFunc		find-if				pprint-exit-if-list-exhausted			zerop
syn keyword lispFunc		find-if-not			pprint-fill



syn match   lispFunc		"\<c[ad]\+r\>"
if exists("g:lispsyntax_clisp")
  " CLISP FFI:
  syn match lispFunc	"\<\(ffi:\)\?with-c-\(place\|var\)\>"
  syn match lispFunc	"\<\(ffi:\)\?with-foreign-\(object\|string\)\>"
  syn match lispFunc	"\<\(ffi:\)\?default-foreign-\(language\|library\)\>"
  syn match lispFunc	"\<\([us]_\?\)\?\(element\|deref\|cast\|slot\|validp\)\>"
  syn match lispFunc	"\<\(ffi:\)\?set-foreign-pointer\>"
  syn match lispFunc	"\<\(ffi:\)\?allocate-\(deep\|shallow\)\>"
  syn match lispFunc	"\<\(ffi:\)\?c-lines\>"
  syn match lispFunc	"\<\(ffi:\)\?foreign-\(value\|free\|variable\|function\|object\)\>"
  syn match lispFunc	"\<\(ffi:\)\?foreign-address\(-null\|unsigned\)\?\>"
  syn match lispFunc	"\<\(ffi:\)\?undigned-foreign-address\>"
  syn match lispFunc	"\<\(ffi:\)\?c-var-\(address\|object\)\>"
  syn match lispFunc	"\<\(ffi:\)\?typeof\>"
  syn match lispFunc	"\<\(ffi:\)\?\(bit\)\?sizeof\>"
" CLISP Macros, functions et al:
  syn match lispFunc	"\<\(ext:\)\?with-collect\>"
  syn match lispFunc	"\<\(ext:\)\?letf\*\?\>"
  syn match lispFunc	"\<\(ext:\)\?finalize\>\>"
  syn match lispFunc	"\<\(ext:\)\?memoized\>"
  syn match lispFunc	"\<\(ext:\)\?getenv\>"
  syn match lispFunc	"\<\(ext:\)\?convert-string-\(to\|from\)-bytes\>"
  syn match lispFunc	"\<\(ext:\)\?ethe\>"
  syn match lispFunc	"\<\(ext:\)\?with-gensyms\>"
  syn match lispFunc	"\<\(ext:\)\?open-http\>"
  syn match lispFunc	"\<\(ext:\)\?string-concat\>"
  syn match lispFunc	"\<\(ext:\)\?with-http-\(in\|out\)put\>"
  syn match lispFunc	"\<\(ext:\)\?with-html-output\>"
  syn match lispFunc	"\<\(ext:\)\?expand-form\>"
  syn match lispFunc	"\<\(ext:\)\?\(without-\)\?package-lock\>"
  syn match lispFunc	"\<\(ext:\)\?re-export\>"
  syn match lispFunc	"\<\(ext:\)\?saveinitmem\>"
  syn match lispFunc	"\<\(ext:\)\?\(read\|write\)-\(integer\|float\)\>"
  syn match lispFunc	"\<\(ext:\)\?\(read\|write\)-\(char\|byte\)-sequence\>"
  syn match lispFunc	"\<\(custom:\)\?\*system-package-list\*\>"
  syn match lispFunc	"\<\(custom:\)\?\*ansi\*\>"
endif

" ---------------------------------------------------------------------
" Lisp Keywords (modifiers): {{{1
syn keyword lispKey		:abort				:from-end			:overwrite
syn keyword lispKey		:adjustable			:gensym				:predicate
syn keyword lispKey		:append				:host				:preserve-whitespace
syn keyword lispKey		:array				:if-does-not-exist		:pretty
syn keyword lispKey		:base				:if-exists			:print
syn keyword lispKey		:case				:include			:print-function
syn keyword lispKey		:circle				:index				:probe
syn keyword lispKey		:conc-name			:inherited			:radix
syn keyword lispKey		:constructor			:initial-contents		:read-only
syn keyword lispKey		:copier				:initial-element		:rehash-size
syn keyword lispKey		:count				:initial-offset			:rehash-threshold
syn keyword lispKey		:create				:initial-value			:rename
syn keyword lispKey		:default			:input				:rename-and-delete
syn keyword lispKey		:defaults			:internal			:size
syn keyword lispKey		:device				:io				:start
syn keyword lispKey		:direction			:junk-allowed			:start1
syn keyword lispKey		:directory			:key				:start2
syn keyword lispKey		:displaced-index-offset		:length				:stream
syn keyword lispKey		:displaced-to			:level				:supersede
syn keyword lispKey		:element-type			:name				:test
syn keyword lispKey		:end				:named				:test-not
syn keyword lispKey		:end1				:new-version			:type
syn keyword lispKey		:end2				:nicknames			:use
syn keyword lispKey		:error				:output				:verbose
syn keyword lispKey		:escape				:output-file			:version
syn keyword lispKey		:external
" defpackage arguments
syn keyword lispKey	:documentation	:shadowing-import-from	:modern		:export
syn keyword lispKey	:case-sensitive	:case-inverted		:shadow		:import-from	:intern
" lambda list keywords
syn keyword lispKey	&allow-other-keys	&aux		&body
syn keyword lispKey	&environment	&key			&optional	&rest		&whole
" make-array argument
syn keyword lispKey	:fill-pointer
" readtable-case values
syn keyword lispKey	:upcase		:downcase		:preserve	:invert
" eval-when situations
syn keyword lispKey	:load-toplevel	:compile-toplevel	:execute
" ANSI Extended LOOP:
syn keyword lispKey	:while      :until       :for         :do       :if          :then         :else     :when      :unless :in
syn keyword lispKey	:across     :finally     :collect     :nconc    :maximize    :minimize     :sum
syn keyword lispKey	:and        :with        :initially   :append   :into        :count        :end      :repeat
syn keyword lispKey	:always     :never       :thereis     :from     :to          :upto         :downto   :below
syn keyword lispKey	:above      :by          :on          :being    :each        :the          :hash-key :hash-keys
syn keyword lispKey	:hash-value :hash-values :using       :of-type  :upfrom      :downfrom
if exists("g:lispsyntax_clisp")
  " CLISP FFI:
  syn keyword lispKey	:arguments  :return-type :library     :full     :malloc-free
  syn keyword lispKey	:none       :alloca      :in          :out      :in-out      :stdc-stdcall :stdc     :c
  syn keyword lispKey	:language   :built-in    :typedef     :external
  syn keyword lispKey	:fini       :init-once   :init-always
endif

" ---------------------------------------------------------------------
" Standard Lisp Variables: {{{1
syn keyword lispVar		*applyhook*			*load-pathname*			*print-pprint-dispatch*
syn keyword lispVar		*break-on-signals*		*load-print*			*print-pprint-dispatch*
syn keyword lispVar		*break-on-signals*		*load-truename*			*print-pretty*
syn keyword lispVar		*break-on-warnings*		*load-verbose*			*print-radix*
syn keyword lispVar		*compile-file-pathname*		*macroexpand-hook*		*print-readably*
syn keyword lispVar		*compile-file-pathname*		*modules*			*print-right-margin*
syn keyword lispVar		*compile-file-truename*		*package*			*print-right-margin*
syn keyword lispVar		*compile-file-truename*		*print-array*			*query-io*
syn keyword lispVar		*compile-print*			*print-base*			*random-state*
syn keyword lispVar		*compile-verbose*		*print-case*			*read-base*
syn keyword lispVar		*compile-verbose*		*print-circle*			*read-default-float-format*
syn keyword lispVar		*debug-io*			*print-escape*			*read-eval*
syn keyword lispVar		*debugger-hook*			*print-gensym*			*read-suppress*
syn keyword lispVar		*default-pathname-defaults*	*print-length*			*readtable*
syn keyword lispVar		*error-output*			*print-level*			*standard-input*
syn keyword lispVar		*evalhook*			*print-lines*			*standard-output*
syn keyword lispVar		*features*			*print-miser-width*		*terminal-io*
syn keyword lispVar		*gensym-counter*		*print-miser-width*		*trace-output*

" ---------------------------------------------------------------------
" Strings: {{{1
syn region			lispString			start=+"+ skip=+\\\\\|\\"+ end=+"+	contains=@Spell
if exists("g:lisp_instring")
 syn region			lispInString			keepend matchgroup=Delimiter start=+"(+rs=s+1 skip=+|.\{-}|+ matchgroup=Delimiter end=+)"+ contains=@lispBaseListCluster,lispInStringString
 syn region			lispInStringString		start=+\\"+ skip=+\\\\+ end=+\\"+ contained
endif

syn region			lispString			start=+•+ skip=+\\\\\|\\"+ end=+•+	contains=@Spell
if exists("g:lisp_instring")
 syn region			lispInString			keepend matchgroup=Delimiter start=+"(+rs=s+1 skip=+|.\{-}|+ matchgroup=Delimiter end=+)"+ contains=@lispBaseListCluster,lispInStringString
 syn region			lispInStringString		start=+\\"+ skip=+\\\\+ end=+\\"+ contained
endif

" ---------------------------------------------------------------------
" Shared with Xlisp, Declarations, Macros, Functions: {{{1
syn keyword lispDecl		defmacro			do-all-symbols		labels
syn keyword lispDecl		defsetf				do-external-symbols	let
syn keyword lispDecl		deftype				do-symbols		locally
syn keyword lispDecl		defun				dotimes			macrolet
syn keyword lispDecl		do*				flet			multiple-value-bind
syn keyword lispDecl		defvar
if exists("g:lispsyntax_clisp")
  " CLISP FFI:
  syn match lispDecl	"\<\(ffi:\)\?def-c-\(var\|const\|enum\|type\|struct\)\>"
  syn match lispDecl	"\<\(ffi:\)\?def-call-\(out\|in\)\>"
  syn match lispDecl	"\<\(ffi:\)\?c-\(function\|struct\|pointer\|string\)\>"
  syn match lispDecl	"\<\(ffi:\)\?c-ptr\(-null\)\?\>"
  syn match lispDecl	"\<\(ffi:\)\?c-array\(-ptr\|-max\)\?\>"
  syn match lispDecl	"\<\(ffi:\)\?[us]\?\(char\|short\|int\|long\)\>"
  syn match lispDecl	"\<\(win32:\|w32\)\?d\?word\>"
  syn match lispDecl	"\<\([us]_\?\)\?int\(8\|16\|32\|64\)\(_t\)\?\>"
  syn keyword lispDecl	size_t off_t time_t handle
endif

" ---------------------------------------------------------------------
" Numbers: supporting integers and floating point numbers {{{1
syn match lispNumber		"-\=\(\.\d\+\|\d\+\(\.\d*\)\=\)\([dDeEfFlL][-+]\=\d\+\)\="
syn match lispNumber		"-\=\(\d\+/\d\+\)"

syn match lispEscapeSpecial		"\*\w[a-z_0-9-]*\*"
syn match lispEscapeSpecial		!#|[^()'`,"; \t]\+|#!
syn match lispEscapeSpecial		!#x\x\+!
syn match lispEscapeSpecial		!#o\o\+!
syn match lispEscapeSpecial		!#b[01]\+!
syn match lispEscapeSpecial		!#\\[ -}\~]!
syn match lispEscapeSpecial		!#[':][^()'`,"; \t]\+!
syn match lispEscapeSpecial		!#([^()'`,"; \t]\+)!
syn match lispEscapeSpecial		!#\\\%(Space\|Newline\|Tab\|Page\|Rubout\|Linefeed\|Return\|Backspace\)!
syn match lispEscapeSpecial		"\<+[a-zA-Z_][a-zA-Z_0-9-]*+\>"

syn match lispConcat		"\s\.\s"
syn match lispParenError	")"

" ---------------------------------------------------------------------
" Comments: {{{1
syn cluster lispCommentGroup	contains=lispTodo,@Spell
syn match   lispComment		";.*$"				contains=@lispCommentGroup
" ADDED BY TONY FISCHETTI
syn match   lispComment "^#!/.*sbcl.*$"
syn match   lispComment "^#!/usr/local/bin/lisp.*"
syn region  lispCommentRegion	start="#|" end="|#"		contains=lispCommentRegion,@lispCommentGroup
syn keyword lispTodo		contained			combak			combak:			todo			todo:

" ---------------------------------------------------------------------
" Synchronization: {{{1
syn sync lines=100

" ---------------------------------------------------------------------
" Define Highlighting: {{{1
" For version 5.7 and earlier: only when not done already
" For version 5.8 and later: only when an item doesn't have highlighting yet
if version >= 508
  command -nargs=+ HiLink hi def link <args>

  HiLink lispAtomNmbr		lispNumber
  HiLink lispAtomMark		lispMark
  HiLink lispInStringString	lispString

  HiLink lispAtom		Identifier
  HiLink lispAtomBarSymbol	Special
  HiLink lispBarSymbol		Special
  HiLink lispComment		Comment
  HiLink lispConcat		Statement
  HiLink lispDecl		Statement
  HiLink lispFunc		Statement
  HiLink lispKey		Type
  HiLink lispMark		Delimiter
  HiLink lispNumber		Number
  HiLink lispParenError		Error
  HiLink lispEscapeSpecial	Type
  HiLink lispString		String
  HiLink lispTodo		Todo
  " HiLink lispVar		Statement
  " HiLink lispVar		Type
  HiLink lispVar		Identifier

  if exists("g:lisp_rainbow") && g:lisp_rainbow != 0
   if &bg == "dark"
    hi def hlLevel0 ctermfg=red         guifg=red1
    hi def hlLevel1 ctermfg=yellow      guifg=orange1
    hi def hlLevel2 ctermfg=green       guifg=yellow1
    hi def hlLevel3 ctermfg=cyan        guifg=greenyellow
    hi def hlLevel4 ctermfg=magenta     guifg=green1
    hi def hlLevel5 ctermfg=red         guifg=springgreen1
    hi def hlLevel6 ctermfg=yellow      guifg=cyan1
    hi def hlLevel7 ctermfg=green       guifg=slateblue1
    hi def hlLevel8 ctermfg=cyan        guifg=magenta1
    hi def hlLevel9 ctermfg=magenta     guifg=purple1
   else
    hi def hlLevel0 ctermfg=red         guifg=red3
    hi def hlLevel1 ctermfg=darkyellow  guifg=orangered3
    hi def hlLevel2 ctermfg=darkgreen   guifg=orange2
    hi def hlLevel3 ctermfg=blue        guifg=yellow3
    hi def hlLevel4 ctermfg=darkmagenta guifg=olivedrab4
    hi def hlLevel5 ctermfg=red         guifg=green4
    hi def hlLevel6 ctermfg=darkyellow  guifg=paleturquoise3
    hi def hlLevel7 ctermfg=darkgreen   guifg=deepskyblue4
    hi def hlLevel8 ctermfg=blue        guifg=darkslateblue
    hi def hlLevel9 ctermfg=darkmagenta guifg=darkviolet
   endif
  endif

  delcommand HiLink
endif

" --------------------------------------------------------------- "
"
" custom keywords/functions/macros

" pluto
syn keyword lispFunc fn
syn keyword lispFunc ft
syn keyword lispFunc *pluto-output-stream*
syn keyword lispFunc *pluto-log-level*
syn keyword lispFunc *pluto-curly-test*
syn keyword lispFunc *pluto-external-format*
syn keyword lispFunc *pluto-log-file*
syn keyword lispFunc magenta
syn keyword lispFunc red
syn keyword lispFunc yellow
syn keyword lispFunc green
syn keyword lispFunc cyan
syn keyword lispFunc blue
syn keyword lispFunc grey
syn keyword lispFunc with-gensyms
syn keyword lispFunc mac
syn keyword lispFunc nil!
syn keyword lispFunc alambda
syn keyword lispFunc self!
syn keyword lispFunc abbr
syn keyword lispFunc flatten
syn keyword lispFunc take
syn keyword lispFunc group
syn keyword lispFunc create-symbol
syn keyword lispFunc create-keyword
syn keyword lispFunc walk-replace-sexp
syn keyword lispFunc -<>
syn keyword lispFunc <>
syn keyword lispFunc aif
syn keyword lispFunc it!
syn keyword lispFunc slurp
syn keyword lispFunc slurp-lines
syn keyword lispFunc barf
syn keyword lispFunc debug-these
syn keyword lispFunc with-a-file
syn keyword lispFunc stream!
syn keyword lispFunc str+
syn keyword lispFunc str-join
syn keyword lispFunc substr
syn keyword lispFunc string->char-list
syn keyword lispFunc split-string->lines
syn keyword lispFunc repeat-string
syn keyword lispFunc interpose
syn keyword lispFunc delim
syn keyword lispFunc defparams
syn keyword lispFunc round-to
syn keyword lispFunc advise
syn keyword lispFunc alistp
syn keyword lispFunc with-hash-entry
syn keyword lispFunc entry!
syn keyword lispFunc if-hash-entry
syn keyword lispFunc if-not-hash-entry
syn keyword lispFunc capture-all-outputs
syn keyword lispFunc with-temp-file
syn keyword lispFunc display-table
syn keyword lispFunc y-or-n-def
syn keyword lispFunc die
syn keyword lispFunc or-die
syn keyword lispFunc or-do
syn keyword lispFunc die-if-null
syn keyword lispFunc error!
syn keyword lispFunc universal->unix-time
syn keyword lispFunc unix->universal-time
syn keyword lispFunc get-unix-time
syn keyword lispFunc make-pretty-time
syn keyword lispFunc get-current-time
syn keyword lispFunc with-time
syn keyword lispFunc time-for-humans
syn keyword lispFunc time!
syn keyword lispFunc progress
syn keyword lispFunc break!
syn keyword lispFunc continue!
syn keyword lispFunc index!
syn keyword lispFunc value!
syn keyword lispFunc key!
syn keyword lispFunc with-interactive-interrupt-handler
syn keyword lispFunc for-each/line
syn keyword lispFunc for-each/list
syn keyword lispFunc for-each/hash
syn keyword lispFunc for-each/vector
syn keyword lispFunc for-each/stream
syn keyword lispFunc for-each/alist
syn keyword lispFunc for-each/call
syn keyword lispFunc for-each
syn keyword lispFunc forever
syn keyword lispFunc zsh
syn keyword lispFunc sh
syn keyword lispFunc zsh-simple
syn keyword lispFunc sh-simple
syn keyword lispFunc λ
syn keyword lispFunc hostname
syn keyword lispFunc sys/info
syn keyword lispFunc get-envvar
syn keyword lispFunc program/script-name
syn keyword lispFunc cmdargs
syn keyword lispFunc def-cli-args
syn keyword lispFunc args!
syn keyword lispFunc bare-args!
syn keyword lispFunc +USAGE-TEXT!+
syn keyword lispFunc print-usage!
syn keyword lispFunc process-args!
syn keyword lispFunc clear-screen
syn keyword lispFunc get-terminal-columns
syn keyword lispFunc ansi-up-line
syn keyword lispFunc ansi-left-all
syn keyword lispFunc ansi-clear-line
syn keyword lispFunc ansi-left-one
syn keyword lispFunc progress-bar
syn keyword lispFunc loading-forever
syn keyword lispFunc with-loading
syn keyword lispFunc give-choices
syn keyword lispFunc basename
syn keyword lispFunc size-for-humans
syn keyword lispFunc file-size
syn keyword lispFunc pwd
syn keyword lispFunc realpath
syn keyword lispFunc inspect-pathname
syn keyword lispFunc ls
syn keyword lispFunc directory-exists-p
syn keyword lispFunc file-exists-p
syn keyword lispFunc file-or-directory-exists-p
syn keyword lispFunc walk-directory
syn keyword lispFunc -path
syn keyword lispFunc +path
syn keyword lispFunc absolute->relative
syn keyword lispFunc change-extension
syn keyword lispFunc file-find

" charon
syn keyword lispFunc re-compile
syn keyword lispFunc str-split
syn keyword lispFunc str-replace
syn keyword lispFunc str-replace-all
syn keyword lispFunc str-detect
syn keyword lispFunc str-subset
syn keyword lispFunc str-extract
syn keyword lispFunc str-scan-to-strings
syn keyword lispFunc str-trim
syn keyword lispFunc ~m
syn keyword lispFunc ~r
syn keyword lispFunc ~ra
syn keyword lispFunc ~s
syn keyword lispFunc ~f
syn keyword lispFunc ~c
syn keyword lispFunc ~e
syn keyword lispFunc with-loading
syn keyword lispFunc request/get
syn keyword lispFunc request/post
syn keyword lispFunc parse-xml
syn keyword lispFunc parse-xml-file
syn keyword lispFunc xpath
syn keyword lispFunc xpath-compile
syn keyword lispFunc use-xml-namespace
syn keyword lispFunc xpath-string
syn keyword lispFunc alist->hash-table
syn keyword lispFunc hash-table->alist
syn keyword lispFunc hash-keys
syn keyword lispFunc parse-json
syn keyword lispFunc hash-table->json
syn keyword lispFunc parse-json-file
syn keyword lispFunc make-octet-vector
syn keyword lispFunc concat-octet-vector
syn keyword lispFunc parse-html
syn keyword lispFunc $$
syn keyword lispFunc parse-float
syn keyword lispFunc escape-namestring/shell
syn keyword lispFunc escape-namestring/c
syn keyword lispFunc pathname->shell
syn keyword lispFunc pathname->c
syn keyword lispFunc *sd-log-priority*
syn keyword lispFunc sd-journal
syn keyword lispFunc stat-filesize
syn keyword lispFunc is-symlink-p
syn keyword lispFunc md5/string
syn keyword lispFunc md5/file
syn keyword lispFunc sha256/string
syn keyword lispFunc sha256/hexstring
syn keyword lispFunc sha256/file
syn keyword lispFunc sha512/string
syn keyword lispFunc sha512/file
syn keyword lispFunc ripemd160/string
syn keyword lispFunc ripemd160/hexstring


syn keyword lispFunc defmarcxmlfield

syn keyword lispDecl defparameter def-cli-args option ~m ~r ~s ~ra
syn keyword lispKey	:LATIN-1 :external-format :UTF-8 :enc
syn keyword lispKey	across     finally     collect     maximize    minimize     sum
syn keyword lispKey	with       initially   into        count        end      repeat
syn keyword lispKey	always     never       thereis     from     to          upto         downto   below
syn keyword lispKey	above      by          on          being    each        the          hash-key
syn keyword lispKey	hash-value hash-values using       of-type  upfrom      downfrom
syn keyword lispKey	quri:url-decode quri:url-encode    λ




syn match Delimiter		!#[':\!]!
syn match lispComment           "^#!/.*sbcl.*$"
syn match lispComment           "^#!/usr/local/bin/lisp.*"
syn match lispEscapeSpecial     "/\w[a-z_0-9-]*/"



" --------------------------------------------------------------- "


let b:current_syntax = "lisp"

" ---------------------------------------------------------------------
" vim: ts=8 nowrap fdm=marker
"
