// js, basics, if else, else if, elif, elseif, ternary operator, switch case

if (between1And10 > 5) {
  console.log("> 5");
} else if (between1And10 <= 5) {
  console.log("<= 5");
} else {
  console.log("idk");
}

/* multiple ternary */
const tmp = between1And10 > 6 ? "7+" :
            between1And10 <= 4 ? "4-" :
            "between 4 and 7";

/* switch-case */
switch (yesOrNo) {
  case "yes":
    console.log("yes, indeed");
    break;
  case "no":
    console.log("no, indeed");
    break;
  default:
    console.log("idk");
}

/* switch-case
 * if else alternative
 */
switch (true) {
  case (between1And10 > 5):
    console.log("> 5");
    break;
  /* Demonstrating fall-through */
  case (between1And10 <= 5):
  case (between1And10 <= 4):
  case (between1And10 <= 3):
    console.log("<= 5");
    break;
  default:
    console.log("idk");
}

