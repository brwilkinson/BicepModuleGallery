# Open PowerShell on newly deployed win10 Azure VM, with outbound Internet access.

# execute the following, which will likely fail, based on not having the assemblies loaded
$cred = [Azure.Identity.DefaultAzureCredential]::new()
#> InvalidOperation: Unable to find type [Azure.Identity.DefaultAzureCredential].

# The easiest way to load them is via Az.Accounts Module
install-module az.accounts
import-module Az.Accounts

# now test again.
#> lets get a token with the following
$cred = [Azure.Identity.DefaultAzureCredential]::new()
$resourceid = 'https://management.azure.com/.default'
$Scope = [Azure.Core.TokenRequestContext]::new($resourceid,'myclient' )
$token = $cred.GetToken($scope,[System.Threading.CancellationToken]::None)
$token

#> Token
#> -----
#> eyJabc7dlukOiJKV1Qieslsl0g0eEJW...

# This will go through all of these methods to retrieve a token.
# https://docs.microsoft.com/en-us/dotnet/api/overview/azure/identity-readme#prerequisites 

# if it fails you will need to auth first. e.g. az or ps az.

login-azaccount

# or

az login

# then

$token = $cred.GetToken($scope,[System.Threading.CancellationToken]::None)
$token


