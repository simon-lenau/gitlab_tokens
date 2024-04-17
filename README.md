gitlab_token_management
================

Utilities to create and modify Gitlab project access tokens from bash: -
create, rotate and revoke access tokens - Grant and revoke
cross-repository CI job token permissions

# Core functions

<pre class="r-output"><code>git_repo_info   
   Return information about the current git project
&#10;   Arguments:      
      --type     &lt;str&gt; 
         The requested type of information about the repo
         Default: api
      --url      &lt;str&gt; 
         The url to obtain the requested info from
         Default: $(git config --get remote.origin.url)
&#10;   Usage:      
      git_repo_info \
         --type     "api" \
         --url      "$(git config --get remote.origin.url)"
</code></pre>
<pre class="r-output"><code>git_token_renew   
   Create or rotate gitlab token via API
&#10;   Arguments:      
      --tokenfile  &lt;str&gt; 
         The file to store the token
         Default: ~/path/to/file
      --api_secret &lt;str&gt; 
         The API secret
         Default: glpat-aG2fJfixfGub6ULt2L5_
&#10;   Usage:      
      git_token_renew \
         --tokenfile  "~/path/to/file" \
         --api_secret "glpat-aG2fJfixfGub6ULt2L5_"
</code></pre>
<pre class="r-output"><code>git_token_access   
   Allow a job (CI) token from the current project to access another project's repo,
   e.g. to clone the repo or access its container registry.
   (Requires a token with API access).
&#10;   Arguments:      
      --from_project &lt;str&gt; 
         Project whichs job tokens should be able to access `to_project`
         Must be on the same host (e.g. $(git) as `to_project`.
         Default: /
      --to_project   &lt;str&gt; 
         Project which should be accessible using `from_project`s job token.
         Must be on the same host (e.g. $(git) as `from_project`.
         Default: /
      --action       &lt;str&gt; 
         Action to perform. Either 'grant' or 'revoke'
         to add or revoke access from `from_project` to `to_project`
         Default: grant
      --api_secret   &lt;str&gt; 
         The API secret
         Default: glpat-aG2fJfixfGub6ULt2L5_
&#10;   Usage:      
      git_token_access \
         --from_project "/" \
         --to_project   "/" \
         --action       "grant" \
         --api_secret   "glpat-aG2fJfixfGub6ULt2L5_"
</code></pre>

# Examples

See `Examples/.env.host`
