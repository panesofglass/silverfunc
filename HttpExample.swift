import System
import System.IO
import System.Threading.Tasks
import Microsoft.AspNetCore.Mvc
import Microsoft.AspNetCore.Http
import Microsoft.Extensions.Logging
import Newtonsoft.Json

open static class HttpExample { 
	public func Run(_ req: HttpRequest!, _ log: ILogger!) -> Task<IActionResult!>! {
		log.LogInformation("Swift HTTP trigger function processed a request.")
		var name: String! = req.Query["name"]
		var requestBody: String! = __await StreamReader(req.Body).ReadToEndAsync()
		var data: Named! = JsonConvert.DeserializeObject<Named>(requestBody)
		name = coalesce(name, data?.name)
		return (name != nil ? (OkObjectResult(String.Format("Hello from Swift, {0}", name)) as? ActionResult) : BadRequestObjectResult("Please pass a name on the query string or in the request body"))
	}
}

