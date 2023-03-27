using Microsoft.AspNetCore.Mvc;

namespace ping_app.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class PingController : ControllerBase
    {
        private readonly ILogger<PingController> _logger;

        public PingController(ILogger<PingController> logger)
        {
            _logger = logger;
        }

        [HttpGet(Name = "ping")]
        public bool Get()
        {
            return true;
        }
    }
}