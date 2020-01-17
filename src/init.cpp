#include <Rcpp.h>
using namespace Rcpp;


// [[Rcpp::export]]
CharacterVector hello_world() {
  return "Hello, World!";
}

/*** R
timesTwo(42)
*/
