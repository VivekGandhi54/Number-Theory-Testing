import os
newPath = os.getcwd() + '/Desktop/Code/MidpointsMath/Scripts'
os.chdir(newPath)

print('\n  ---  Entered directory  ---  \n')

print('  ---  Attaching library files  ---  \n')

attach('Lib.sage')
print('  Attached Lib.sage')
attach('PhiSumLibs.sage')
print('  Attached PhiSumLibs.sage')
attach('OldLibs.sage')
print('  Attached OldLibs.sage')

print('\n  ---  Attached library files  ---  \n')

print('  ---  Running tests  ---  \n')

load('LibTests.sage')

print('\n  ---  Ready to start  ---')

files()
