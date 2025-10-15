from unittest import TestCase
import pytoulbar2

class TestExtension(TestCase):
   def test_1(self):
      myCFN = pytoulbar2.CFN(2)
      res = myCFN.Solve()
      self.assertEqual(res[0],[])
      self.assertEqual(res[1],0.0)
      self.assertEqual(res[2],1)
 

   def test_2(self):

      cfn = pytoulbar2.CFN()
      cfn.Read("./example.wcsp")
      cfn.Option.setVarOrder("-3")
      res = cfn.Solve()
      assert(res and res[1]==27)

   # this test comes from the tutorial
   def test_3(self):

      cfn = pytb2.CFN()

      # variables
      for row in range(9):
         for col in range(9):
            cfn.AddVariable('cell_'+str(row)+'_'+str(col), range(9))

      # define known values
      initial_values = [[5,3,0,0,7,0,0,0,0],
                     [6,0,0,1,9,5,0,0,0],
                     [0,9,8,0,0,0,0,6,0],
                     [8,0,0,0,6,0,0,0,3],
                     [4,0,0,8,0,3,0,0,1],
                     [7,0,0,0,2,0,0,0,6],
                     [0,6,0,0,0,0,2,8,0],
                     [0,0,0,4,1,9,0,0,5],
                     [0,0,0,0,8,0,0,7,9]]

      var_index = 0
      for row in range(9):
         for col in range(9):
            if initial_values[row][col] != 0:
                  cfn.Assign(var_index, initial_values[row][col]-1)
            var_index += 1

      # row constraints
      for row_ind in range(9):
         cfn.AddAllDifferent([row_ind*9+col_ind for col_ind in range(9)])

      # column constraints
      for col_ind in range(9):
         cfn.AddAllDifferent([row_ind*9+col_ind for row_ind in range(9)])

      # sub grids constraints
      for sub_ind1 in range(3): # row offset
         for sub_ind2 in range(3): # column offset
            cfn.AddAllDifferent([(sub_ind1*3+row_ind)*9+ sub_ind2*3+col_ind for col_ind in range(3) for row_ind in range(3)])
                     
      result = cfn.Solve(showSolutions = 3, allSolutions=1)


