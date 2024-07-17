window.addEventListener("message", (event) => {
  switch (event.data.action) {
    case "open":
      Open(event.data);
      break;
    case "close":
      Close();
      break;
    case "setup":
      Setup(event.data);
      break;
  }
});

const Open = (data) => {
  $(".scoreboard-block").fadeIn(150);
  $("#total-players").html("<p>" + data.players + "/" + data.maxPlayers + "</p>");
  $("#servername").html(data.servername);
  $("#currentcops").html(data.currentCops);
  $("#currentAmbulance").html(data.ambulanceCount);
  $("#currentMechanic").html(data.mechanicCount);
  $("#currentTaxi").html(data.taxiCount);
  $("#ping-value").html(data.ping);
  $("#name-value").html(data.name);
  $("#player-job").html(data.job);
  $("#player-rank").html(data.grade);
  $("#id-value").html(data.id);
  $("#pl-value").html(data.packetLoss);

  $.each(data.requiredCops, (i, category) => {
    var beam = $(".scoreboard-info").find('[data-type="' + i + '"]');
    var status = $(beam).find(".info-beam-status");
    var dutyToggle = $(".duty-toggle");

    if (data.duty) {
      dutyToggle.html('<i class="fa-solid fa-toggle-on"></i>');
    } else {
      dutyToggle.html('<i class="fa-solid fa-toggle-off"></i>');
    }
    // For anyone wondering, this does work, you can leave the brackets out if you have just one line of code to execute
    if (category.busy)
      $(status).html('<i class="fas fa-clock"></i>');
    else if (data.currentCops >= category.minimumPolice)
      $(status).html('<i class="fa-solid fa-circle-check" style="color: #0ed600;"></i>');
    else
      $(status).html('<i class="fa-solid fa-circle-xmark" style="color: #f90101;"></i>');
  });
};

const Close = () => {
  $(".scoreboard-block").fadeOut(150);
};

const Setup = (data) => {
  let scoreboardHtml = "";
  $.each(data.items, (index, value) => {
    scoreboardHtml += `
      <div class="scoreboard-info-beam" data-type=${index}>
        <div class="info-beam-title">
            <p>${value}</p>
        </div>
        <div class="info-beam-status"></div>
        </div>
        `;
  });

  $(".scoreboard-info").html(scoreboardHtml);
};
