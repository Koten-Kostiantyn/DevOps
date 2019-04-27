This code:
```
env.MY_OAUTH_NAME="For Memo Engine"
sh '''
output=$(echo "some text1=\"$MY_OAUTH_NAME\"_")
output=$(echo "some text1=\\"$MY_OAUTH_NAME\\"_")
output=$(echo "some text2=\\'$MY_OAUTH_NAME\\'_")
output=$(echo "some text2=\'$MY_OAUTH_NAME\'_")
output=$(echo "some text2=\\\'$MY_OAUTH_NAME\\\'_")
'''
```
Will give you this output:
```
++ echo 'some text1=For' Memo Engine_
+ output='some text1=For Memo Engine_'
++ echo 'some text1="For Memo Engine"_'
+ output='some text1="For Memo Engine"_'
++ echo 'some text2=\'\''For Memo Engine\'\''_'
+ output='some text2=\'\''For Memo Engine\'\''_'
++ echo 'some text2='\''For Memo Engine'\''_'
+ output='some text2='\''For Memo Engine'\''_'
++ echo 'some text2=\'\''For Memo Engine\'\''_'
+ output='some text2=\'\''For Memo Engine\'\''_'
```
