#include "libwrapper.h"
#include "inputfile_parse/CSPSpec.h"
#include "inputfile_parse/InputVariableDef.h"
#include "solver.h"
#include <memory>


using namespace ProbSpec;


bool callback(void) {
  std::cout << "Callback!" << endl;
  return true;
}

int main(int argc, char *argv[])
{

  SearchOptions options;
  SearchMethod args;
  CSPInstance instance;

  // encode the following model
  /*
  MINION 3
  **VARIABLES**
  DISCRETE x #
  {1..3}
  DISCRETE y #
  {1..3}
  DISCRETE z #
  {1..3}
  **SEARCH**
  PRINT[[x],[y],[z]]
  VARORDER STATIC [x, y, z]
  **CONSTRAINTS**
  sumleq([x,y],z)
  sumgeq([x,y],z)
  **EOF**
  */

  std::vector<DomainInt> domain = {1,3};
  
  // **VARIABLES**
  newVar(instance,"x",VAR_DISCRETE,domain);
  newVar(instance,"y",VAR_DISCRETE,domain);
  newVar(instance,"z",VAR_DISCRETE,domain);

  Var x = instance.vars.getSymbol("x");
  Var y = instance.vars.getSymbol("y");
  Var z = instance.vars.getSymbol("z");

  // **SEARCH**
  
  // PRINT
  instance.print_matrix.push_back({x});
  instance.print_matrix.push_back({y});
  instance.print_matrix.push_back({z});


  // VARORDER STATIC [x,y,z]
  bool find_one_sol = false;
  SearchOrder searchOrder({x,y,z}, VarOrderEnum::ORDER_STATIC,find_one_sol);
  instance.searchOrder.push_back(searchOrder);


  // **CONSTRAINTS**
  
  ConstraintBlob leq(lib_getConstraint(ConstraintType::CT_LEQSUM));
  ConstraintBlob geq(lib_getConstraint(ConstraintType::CT_GEQSUM));

  
  leq.vars.push_back({x,y});
  leq.vars.push_back({z});
                      
  geq.vars.push_back({x,y});
  geq.vars.push_back({z});

  instance.constraints.push_back(leq);
  instance.constraints.push_back(geq);

  for (int i=0;i<5;i++){
    printf("\n========== RUN %d ==========\n",i);
    runMinion(options,args,instance,&callback);
  }
}
