<?php 
namespace App\Controller;

use App\Entity\ReleveNotes;
use Doctrine\DBAL\Connection;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

class ReleveNoteController extends AbstractController
{
    private $connection; 

    public function __construct(Connection $connection)
    {
        $this->connection = $connection;
    }

    #[Route('/releve/note', name: 'app_releve_note')]
    public function getReleveNotes(): Response
    {
        $releveNotesInstance = new ReleveNotes();

        // Récupérer les relevés de notes
        $releveNotes = $releveNotesInstance->getAllReleveNotes($this->connection);

        // Créer la réponse JSON
        $response = $this->json($releveNotes);

        // Ajouter les en-têtes CORS pour autoriser les requêtes depuis localhost:5173
        $response->headers->set('Access-Control-Allow-Origin', '*');
        $response->headers->set('Access-Control-Allow-Methods', 'GET, POST, OPTIONS');
        $response->headers->set('Access-Control-Allow-Headers', 'Content-Type');

        return $response;
    }
}
