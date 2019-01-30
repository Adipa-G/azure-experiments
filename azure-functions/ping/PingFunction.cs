using System.Linq;
using System.Linq.Expressions;
using System.Net;
using System.Net.Http;
using System.Text;
using System.Threading.Tasks;
using Microsoft.Azure.WebJobs;
using Microsoft.Azure.WebJobs.Extensions.Http;
using Microsoft.Azure.WebJobs.Host;
using Newtonsoft.Json;

namespace ping
{
    public static class PingFunction
    {
        [FunctionName("ping")]
        public static async Task<HttpResponseMessage> Run(
            [HttpTrigger(AuthorizationLevel.Function, "get", "post", Route = null)]HttpRequestMessage req,
            TraceWriter log)
        {
            log.Info("Ping request.");

            return await Task.FromResult(new HttpResponseMessage(HttpStatusCode.OK)
            {
                RequestMessage = req,
                Content = new StringContent(JsonConvert.SerializeObject("alive"),Encoding.UTF8,"application/json")
            });
        }
    }
}
