// js, ts, eslint, lint, stylistic, eslint.config.js

/*
 * npm i -D eslint @eslint/js typescript-eslint @stylistic/eslint-plugin
 */

/*
 * IN package.json...
 *
 * "scripts":
 *   "lint": "npx eslint . --ignore-pattern dist/ --ignore-pattern node_modules/ --ignore-pattern .git/ --ignore-pattern src/types/types.d.ts --ignore-pattern eslint.config.js",
 *   ...
 */

/*
 * eslint.config.js
 */

import globals from "globals";
import pluginJs from "@eslint/js";
import tseslint from "typescript-eslint";
import stylistic from '@stylistic/eslint-plugin';


export default [
  pluginJs.configs.recommended,
  ...tseslint.configs.recommended,
  {
    // idk why this isnt working... specified on cli, instead
    "ignores": ["node_modules/", ".git/", "dist/", "src/types/types.d.ts", "eslint.config.js"],
    "languageOptions": {
      "globals": {
        ...globals.browser,
        ...globals.node
      },
    },
    plugins: {
      '@stylistic': stylistic
    },
    rules: {
      "eqeqeq":                             "error",
      "no-undef":                           "off",
      "no-unused-vars":                     "off",
      "no-console":                         "warn",
      "no-alert":                           "warn",
      "no-useless-call":                    "error",
      "no-useless-computed-key":            "error",
      "no-useless-constructor":             "error",
      "no-useless-rename":                  "error",
      "no-useless-return":                  "error",
      "no-useless-backreference":           "error",
      "no-useless-catch":                   "error",
      "no-var":                             "error",
      "use-isnan":                          "error",
      "prefer-arrow-callback":              "error",
      "prefer-const":                       "error",
      "no-octal-escape":                    "error",
      "no-eval":                            "error",
      "no-implied-eval":                    "error",
      "no-labels":                          "error",
      "array-callback-return":              "error",
      "no-duplicate-imports":               "error",
      "no-global-assign":                   "error",
      "no-implicit-globals":                "error",
      "no-sequences":                       "error",
      "no-shadow":                          "error",
      "prefer-named-capture-group":         "error",
      "yoda":                               "error",
      "curly":                              "error",
      "default-case":                       "error",
      "default-case-last":                  "error",
      "default-param-last":                 "error",
      "max-lines-per-function":             "error",
      "no-delete-var":                      "error",
      "no-eq-null":                         "error",
      "no-empty-function":                  "error",
      "func-style":                         ["error", "expression"],
      "max-depth":                          ["error", 4],
      "no-empty":                           ["error", { allowEmptyCatch: true }],
      "no-constant-condition":              ["error", { checkLoops: false }],
      "camelcase":                          ["error", { properties: "always" }],

      "@typescript-eslint/no-unused-vars":  "off",
      "@typescript-eslint/no-var-requires": "off",

      "@stylistic/max-statements-per-line":       "error",
      "@stylistic/no-mixed-spaces-and-tabs":      "error",
      "@stylistic/semi":                          "error",
      "@stylistic/no-tabs":                       "error",
      "@stylistic/no-trailing-spaces":            "error",
      "@stylistic/one-var-declaration-per-line":  "error",
      "@stylistic/rest-spread-spacing":           "error",
      "@stylistic/type-generic-spacing":          "error",
      "@stylistic/comma-spacing":                 "error",
      "@stylistic/comma-style":                   "error",
      "@stylistic/arrow-spacing":                 "error",
      "@stylistic/function-call-spacing":         "error",
      "@stylistic/key-spacing":                   "error",
      "@stylistic/keyword-spacing":               "error",
      "@stylistic/linebreak-style":               "error",
      "@stylistic/member-delimiter-style":        "error",
      "@stylistic/new-parens":                    "error",
      "@stylistic/no-confusing-arrow":            "error",
      "@stylistic/no-extra-semi":                 "error",
      // "@stylistic/multiline-comment-style": "warn",
      "@stylistic/arrow-parens":                  ["error", "always"],
      "@stylistic/type-annotation-spacing":       ["error", { before: true, after: true, }],
      "@stylistic/indent":                        ["warn", 2, { SwitchCase: 1 }],
      "@stylistic/brace-style":                   ["error", "1tbs", { allowSingleLine: true }],
      "@stylistic/max-len": ["error", 80, {
          ignoreComments: false,
          ignoreUrls: false,
          ignoreStrings: false,
          ignoreTemplateLiterals: false,
          ignoreRegExpLiterals: false
      }],
    },
  },
];


