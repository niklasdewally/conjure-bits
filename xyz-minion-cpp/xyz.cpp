#include "libwrapper.h"
#include "inputfile_parse/CSPSpec.h"
#include "inputfile_parse/InputVariableDef.h"
#include "solver.h"
#include <memory>


using namespace ProbSpec;

extern Globals* globals;

bool callback(void) {
  std::cout << "Callback!" << endl;
  std::cout << "x: " << globals->state_m->getPrintMatrix()[0][0].assignedValue() << endl;
  std::cout << "y: " << globals->state_m->getPrintMatrix()[1][0].assignedValue() << endl;
  std::cout << "z: " << globals->state_m->getPrintMatrix()[2][0].assignedValue() << endl;
  return true;
}

int main(int argc, char *argv[])
{

  SearchOptions options;
  SearchMethod args;
  CSPInstance instance;

  std::vector<DomainInt> domainx = {1,3};
  std::vector<DomainInt> domainy = {2,4};
  std::vector<DomainInt> domainz = {1,5};
  
  // **VARIABLES**
  newVar(instance,"x",VAR_DISCRETE,domainx);
  newVar(instance,"y",VAR_DISCRETE,domainy);
  newVar(instance,"z",VAR_DISCRETE,domainz);

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
  ConstraintBlob ineq(lib_getConstraint(ConstraintType::CT_INEQ));

  
  // leq: [var] var
  leq.vars.push_back({x,y,z});
  leq.vars.push_back({constantAsVar(4)});
                      
  geq.vars.push_back({x,y,z});
  geq.vars.push_back({constantAsVar(4)});

  // ineq: var var const
  ineq.vars.push_back({x});
  ineq.vars.push_back({y});
  ineq.constants.push_back({-1});

  instance.constraints.push_back(geq);
  instance.constraints.push_back(leq);
  instance.constraints.push_back(ineq);

  for (int i=0;i<5;i++){
    printf("\n========== RUN %d ==========\n",i);
    runMinion(options,args,instance,&callback);
  }
}
