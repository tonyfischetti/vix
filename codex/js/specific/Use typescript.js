
/*
 * npm i -D typescript globals [rimraf] @types/node (@types/papaparse, etc...)
 */

/*
 * IN package.json...
 *
 * "scripts":
 *   "build": "npx rimraf ./dist  && npx tsc --project tsconfig.json",
 *   "start:dev": "npx tsc -w --project tsconfig.json",
 *   ...
 */

/*
 * tsconfig.json
 */

{
  "compilerOptions": {
    "baseUrl": ".",
    "typeRoots": ["./node_modules/@types", "./src/types"],
    "module": "NodeNext",
    "moduleResolution": "NodeNext",
    "target": "ES2020",
    "sourceMap": true,
    "outDir": "dist",
    "lib": [ "ES2021.String" ],
    "noImplicitAny": true,
    "noUnusedLocals": true, 
    "noUnusedParameters": true,
    "noImplicitReturns": true,
    "noFallthroughCasesInSwitch": true,
    "allowJs": true,
    "checkJs": true,
    "forceConsistentCasingInFileNames": true,
    "composite": true,
    "skipLibCheck": true,
    "noFallthroughCasesInSwitch": true,
    "allowUnusedLabels": false,
    "allowUnreachableCode": false,
    "strictNullChecks": true,
    "exactOptionalPropertyTypes": true,
    "noFallthroughCasesInSwitch": true,
    "noImplicitOverride": true,
    "noImplicitReturns": true,
    "noPropertyAccessFromIndexSignature": true,
    "noUncheckedIndexedAccess": true,
    "strict": true
  },
  "include": ["index.ts", "main.ts", "app.ts", "index.js", "main.js", "app.js", "src/**/*"],
  "exclude": ["node_modules"]
}

