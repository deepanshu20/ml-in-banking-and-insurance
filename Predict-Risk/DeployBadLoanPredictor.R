library(h2o)
h2o.init(nthreads = 1, max_mem_size = "1500m")

# This is the deployable function

approveLoan <- function(Loan_Amount,Term,Interest_Rate,Employment_Years,Home_Ownership,Annual_Income,Verification_Status,Loan_Purpose,State,
                        Debt_to_Income,Delinquent_2yr,Revolving_Cr_Util,Total_Accounts,Longest_Credit_Length){
  h2o.connect()
  h2o.removeAll()
 
  loanApplication <- data.frame('Loan_Amount' = Loan_Amount,
                                'Term' = Term,
                                'Interest_Rate' = Interest_Rate, 
                                'Employment_Years' = Employment_Years,
                                'Home_Ownership' = Home_Ownership,
                                'Annual_Income' = Annual_Income,
                                'Verification_Status'= Verification_Status,
                                'Loan_Purpose' = Loan_Purpose,
                                'State' = State,
                                'Debt_to_Income' = Debt_to_Income,
                                'Delinquent_2yr' = Delinquent_2yr,
                                'Revolving_Cr_Util' = Revolving_Cr_Util,
                                'Total_Accounts' = Total_Accounts,
                                'Longest_Credit_Length' = Longest_Credit_Length)
  
  newLoanApplicationH2O = as.h2o(x = loanApplication)
  #newLoanApplicationH2O = h2o.importFile(path = "loanApplication.csv")
  loanApprover <- h2o.loadModel(path = "LoanApprover.model")
  prediction = h2o.predict(object = loanApprover, newdata = newLoanApplicationH2O)
  pred = as.data.frame(prediction)
  values = toString(pred[1,1])
 return(values)
}

